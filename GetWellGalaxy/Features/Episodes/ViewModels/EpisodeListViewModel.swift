//
//  EpisodeListViewModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation
import Observation

@MainActor
@Observable final class EpisodeListViewModel {
    private(set) var episodes: [Episode]
    private(set) var isInitialLoading = false
    private(set) var isLoadingMore = false
    private(set) var hasMorePages = true
    private(set) var errorMessage: String?
    private(set) var lastRefreshedAt: Date?
    private(set) var paginationBlockedByError = false

    private let service: EpisodesServicing
    private let cacheStore: EpisodesPersisting
    private var currentPage = 1

    init(
        service: EpisodesServicing = EpisodesAPIService(),
        cacheStore: EpisodesPersisting = EpisodesSwiftDataStore.shared,
        episodes: [Episode] = []
    ) {
        self.service = service
        self.cacheStore = cacheStore
        self.episodes = episodes
    }
    
    var canAutoLoadNextPage: Bool {
        hasMorePages && !isLoadingMore && !paginationBlockedByError
    }

    func loadInitialIfNeeded() async {
        guard episodes.isEmpty else { return }
        
        do {
            let cached = try await cacheStore.loadEpisodes()
            if !cached.isEmpty {
                episodes = cached
                hasMorePages = true
                currentPage = 1
            }
        } catch is CancellationError {
            return
        } catch {
            // Keep silent for mvp phase
        }
        
        isInitialLoading = true
        defer { isInitialLoading = false }
        
        await loadNextPage()
    }

    func loadNextPage(isUserInitiated: Bool = false) async {
        guard hasMorePages, !isLoadingMore else { return }
        if !isUserInitiated && paginationBlockedByError { return }
        
        isLoadingMore = true
        defer { isLoadingMore = false }
        let pageToLoad = currentPage
        
        do {
            try Task.checkCancellation()
            let response = try await service.fetchEpisodes(page: pageToLoad)

            try Task.checkCancellation()
            let newItems = response.results.filter { newItem in
                !episodes.contains(where: { $0.id == newItem.id })
            }
            episodes.append(contentsOf: newItems)
            
            currentPage = pageToLoad + 1
            hasMorePages = (response.info.next != nil)
            errorMessage = nil
            paginationBlockedByError = false
            
            if !episodes.isEmpty {
                try await cacheStore.saveEpisodes(episodes)
            }
            
            if pageToLoad == 1 {
                lastRefreshedAt = .now
            }
        } catch is CancellationError {
            return
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = String(localized: .errorEpisodesFailedToLoad)
            }

            if !episodes.isEmpty {
                paginationBlockedByError = true
            }
        }
    }
    
    func retry() async {
        if episodes.isEmpty {
            await loadInitialIfNeeded()
        } else {
            paginationBlockedByError = false
            await loadNextPage(isUserInitiated: true)
        }
    }

    func clearError() {
        errorMessage = nil
    }
    
}

extension EpisodeListViewModel {
    func refresh() async {
        errorMessage = nil
        currentPage = 1
        hasMorePages = true
        paginationBlockedByError = false
        
        do {
            try Task.checkCancellation()
            let response = try await service.fetchEpisodes(page: 1)
            episodes = response.results
            currentPage = 2
            hasMorePages = (response.info.next != nil)
            
            if !episodes.isEmpty {
                try await cacheStore.saveEpisodes(episodes)
            }
            lastRefreshedAt = .now
        } catch is CancellationError {
            return
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = String(localized: .errorEpisodesFailedToLoad)
            }

            if !episodes.isEmpty {
                paginationBlockedByError = true
            }
        }
    }
}
