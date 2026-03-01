//
//  EpisodesBackgroundRefreshWorker.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

struct EpisodesBackgroundRefreshWorker {
    private let episodesService: EpisodesServicing
    private let episodesStore: EpisodesPersisting
    
    init(
        episodesService: EpisodesServicing = EpisodesAPIService(),
        episodesStore: EpisodesPersisting = EpisodesCacheStore.shared
    ) {
        self.episodesService = episodesService
        self.episodesStore = episodesStore
    }
    
    func refreshAllEpisodes() async -> Bool {
        do {
            var page = 1
            var hasMorePages = true
            var allEpisodes: [Episode] = []
            
            while hasMorePages {
                try Task.checkCancellation()
                let response = try await episodesService.fetchEpisodes(page: page)
                allEpisodes.append(contentsOf: response.results)
                hasMorePages = (response.info.next != nil)
                page += 1
            }
            
            try Task.checkCancellation()
            try await episodesStore.saveEpisodes(allEpisodes)
            
            return !Task.isCancelled
        } catch {
            return false
        }
    }
}
