//
//  CharacterExportServiceTests.swift
//  GetWellGalaxyTests
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import Testing
@testable import GetWellGalaxy

struct CharacterExportServiceTests {

    @Test func makeJson_containsRequiredCharacterFields() throws {
        let sut = CharacterExportService()
        let character = CharacterDetails(
            id: 1,
            name: "Truman Burbank",
            status: "Alive",
            species: "Human",
            origin: CharacterOrigin(name: "Earth", url: "https://sometrumanapi.com/api/location/1"),
            image: "https://sometrumanapi.com/api/character/image/1.jpeg",
            episode: [
                "https://sometrumanapi.com/api/episode/1",
                "https://sometrumanapi.com/api/episode/2"
            ]
        )
        let jsonDocument = try sut.makeJson(from: character)
        let decoded = try JSONDecoder().decode(CharacterExportPayload.self, from: jsonDocument.data)
        
        #expect(decoded == CharacterExportPayload(
            name: character.name,
            status: character.status,
            species: character.species,
            originName: character.origin.name,
            episodeCount: character.episode.count
        ))
    }

}
