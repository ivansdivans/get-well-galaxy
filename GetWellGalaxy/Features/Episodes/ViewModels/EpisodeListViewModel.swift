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

    private let service: EpisodesServicing
    private let cacheStore: EpisodesPersisting
    private var currentPage = 1

    init(
        service: EpisodesServicing,
        cacheStore: EpisodesPersisting = EpisodesCacheStore.shared,
        episodes: [Episode] = []
    ) {
        self.service = service
        self.cacheStore = cacheStore
        self.episodes = episodes
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

    func loadNextPage() async {
        guard hasMorePages, !isLoadingMore else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            try Task.checkCancellation()
            let response = try await service.fetchEpisodes(page: currentPage)

            try Task.checkCancellation()
            let newItems = response.results.filter { newItem in
                !episodes.contains(where: { $0.id == newItem.id })
            }
            episodes.append(contentsOf: newItems)
            currentPage += 1
            hasMorePages = (response.info.next != nil)
            errorMessage = nil
            
            if !episodes.isEmpty {
                try await cacheStore.saveEpisodes(episodes)
            }
        } catch is CancellationError {
            return
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = String(localized: .errorEpisodesFailedToLoad)
            }
        }
    }
    
    func retry() async {
        if episodes.isEmpty {
            await loadInitialIfNeeded()
        } else {
            await loadNextPage()
        }
    }

    func clearError() {
        errorMessage = nil
    }
}
