//
//  EpisodesBackgroundRefreshWorker.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

struct EpisodesBackgroundRefreshWorker {
    private let episodesService: EpisodesServicing
    // TODO: add EpisodesPersisting protocol and json file implementation for mvp phase
    
    init(episodesService: EpisodesServicing) {
        self.episodesService = episodesService
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
            
            // TODO: add episodes saving to json
            return !Task.isCancelled
        } catch {
            return false
        }
    }
}
