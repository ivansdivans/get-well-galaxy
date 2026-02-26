//
//  EpisodeListViewModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation
import SwiftUI

@Observable final class EpisodeListViewModel {
    private(set) var episodes: [Episode] = []
    private(set) var isInitialLoading = false
    
    private let service: EpisodesServicing
    
    init(
        service: EpisodesServicing,
        episodes: [Episode] = []
    ) {
        self.service = service
        self.episodes = episodes
    }
    
    func loadInitialIfNeeded() async {
        guard episodes.isEmpty else { return }
        isInitialLoading = true
        defer { isInitialLoading = false }
        
        do {
            let response = try await service.fetchEpisodes(page: 1)
            episodes = response.results
        } catch {
            print("initial loading error: \(error)")
        }
    }
}
