//
//  EpisodesStoreMock.swift
//  GetWellGalaxyTests
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
@testable import GetWellGalaxy

actor EpisodesStoreMock: EpisodesPersisting {
    var loadResult: Result<[Episode], Error> = .success([])
    var saveError: Error?
    private var lastSaved: [Episode]?
    
    func loadEpisodes() async throws -> [Episode] {
        try loadResult.get()
    }
    
    func saveEpisodes(_ episodes: [Episode]) async throws {
        if let saveError {
            throw saveError
        }
        lastSaved = episodes
    }
}

// MARK: - Helper methods to access actor-isolated property
extension EpisodesStoreMock {
    func lastSavedEpisodes() -> [Episode]? {
        lastSaved
    }
}
