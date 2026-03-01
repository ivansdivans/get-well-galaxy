//
//  CharacterPersistenceModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import SwiftData

@Model
final class CharacterPersistenceModel {
    @Attribute(.unique) var id: Int
    var name: String
    var status: String
    var species: String
    var originName: String
    var image: String
    var episodeCount: Int
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        originName: String,
        image: String,
        episodeCount: Int
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.originName = originName
        self.image = image
        self.episodeCount = episodeCount
    }
}
