//
//  Episode.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation

struct EpisodeResponse: Decodable {
    let info: EpisodeInfo
    let results: [Episode]
}

struct EpisodeInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Episode: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}
