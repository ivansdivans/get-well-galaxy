//
//  EpisodesCacheStore.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

actor EpisodesCacheStore: EpisodesPersisting {
    static let shared = EpisodesCacheStore()
    
    private init() {}
    
    private let fileURL: URL = {
        let base = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return base.appendingPathComponent("episodes-cache.json")
    }()
    
    func loadEpisodes() async throws -> [Episode] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Episode].self, from: data)
    }
    
    func saveEpisodes(_ episodes: [Episode]) async throws {
        let data = try JSONEncoder().encode(episodes)
        try data.write(to: fileURL, options: .atomic)
    }
}
