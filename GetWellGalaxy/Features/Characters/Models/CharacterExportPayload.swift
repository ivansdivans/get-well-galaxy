//
//  CharacterExportPayload.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

struct CharacterExportPayload: Codable {
    let name: String
    let status: String
    let species: String
    let originName: String
    let episodeCount: Int
}
