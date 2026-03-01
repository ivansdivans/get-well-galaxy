//
//  CharacterExportService.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

struct CharacterExportService: CharacterExportServicing {
    func makeJSON(from character: CharacterDetails) throws -> CharacterDetailsJson {
        let payload = CharacterExportPayload(
            name: character.name,
            status: character.status,
            species: character.species,
            originName: character.origin.name,
            episodeCount: character.episode.count
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        let data = try encoder.encode(payload)
        
        return CharacterDetailsJson(data: data)
    }
    
    func makeDefaultFileName(from character: CharacterDetails) -> String {
        let sanitizedName = character.name
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
        let timestamp = DateFormatterHelper.exportFileNameDateFormatter.string(from: Date())
        
        return "character-\(sanitizedName)-\(timestamp)"
    }
}
