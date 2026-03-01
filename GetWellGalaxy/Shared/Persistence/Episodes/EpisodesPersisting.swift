//
//  EpisodesPersisting.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

protocol EpisodesPersisting {
    func loadEpisodes() async throws -> [Episode]
    func saveEpisodes(_ episodes: [Episode]) async throws
}
