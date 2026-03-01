//
//  EpisodesSwiftDataStore.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import SwiftData

actor EpisodesSwiftDataStore: EpisodesPersisting {
    static let shared = EpisodesSwiftDataStore(container: AppModelContainer.shared)
    
    private let container: ModelContainer
    
    private init(container: ModelContainer) {
        self.container = container
    }
    
    func loadEpisodes() async throws -> [Episode] {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<EpisodePersistenceModel>(
            sortBy: [SortDescriptor(\.id, order: .forward)]
        )
        
        let loadedEpisodes = try context.fetch(descriptor)
        return loadedEpisodes.map { item in
            Episode(
                id: item.id,
                name: item.name,
                airDate: item.airDate,
                episode: item.episode,
                characters: item.characters
            )
        }
    }
    
    func saveEpisodes(_ episodes: [Episode]) async throws {
        let context = ModelContext(container)
        
        try context.delete(model: EpisodePersistenceModel.self)
        for episode in episodes {
            let newItem = EpisodePersistenceModel(
                id: episode.id,
                name: episode.name,
                airDate: episode.airDate,
                episode: episode.episode,
                characters: episode.characters
            )
            context.insert(newItem)
        }
        try context.save()
    }
}
