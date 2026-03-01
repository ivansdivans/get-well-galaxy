//
//  EpisodePersistenceModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import SwiftData

@Model
final class EpisodePersistenceModel {
    @Attribute(.unique) var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]

    init(
        id: Int,
        name: String,
        airDate: String,
        episode: String,
        characters: [String]
    ) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
    }
}
