//
//  CharacterDetails.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

struct CharacterDetails: Decodable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let origin: CharacterOrigin
    let image: String
    let episode: [String]
}

struct CharacterOrigin: Decodable, Equatable {
    let name: String
    let url: String
}
