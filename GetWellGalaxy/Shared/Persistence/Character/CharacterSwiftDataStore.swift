//
//  CharacterSwiftDataStore.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import SwiftData

actor CharacterSwiftDataStore: CharacterPersisting {
    static let shared = CharacterSwiftDataStore(container: AppModelContainer.shared)
    
    private let container: ModelContainer
    
    private init(container: ModelContainer) {
        self.container = container
    }
    
    func loadCharacter(id: Int) async throws -> CharacterDetails? {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<CharacterPersistenceModel>(
            predicate: #Predicate { $0.id == id }
        )

        guard let item = try context.fetch(descriptor).first else {
            return nil
        }

        return CharacterDetails(
            id: item.id,
            name: item.name,
            status: item.status,
            species: item.species,
            origin: CharacterOrigin(name: item.originName, url: item.originURL),
            image: item.image,
            episode: item.episodes
        )
    }
    
    func saveCharacter(_ character: CharacterDetails) async throws {
        let context = ModelContext(container)
        let characterID = character.id
        let descriptor = FetchDescriptor<CharacterPersistenceModel>(
            predicate: #Predicate { $0.id == characterID }
        )

        if let existing = try context.fetch(descriptor).first {
            existing.name = character.name
            existing.status = character.status
            existing.species = character.species
            existing.originName = character.origin.name
            existing.originURL = character.origin.url
            existing.image = character.image
            existing.episodes = character.episode
        } else {
            let newItem = CharacterPersistenceModel(
                id: character.id,
                name: character.name,
                status: character.status,
                species: character.species,
                originName: character.origin.name,
                originURL: character.origin.url,
                image: character.image,
                episodes: character.episode
            )
            context.insert(newItem)
        }
        try context.save()
    }
}
