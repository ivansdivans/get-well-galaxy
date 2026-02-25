//
//  EpisodesServicing.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation

protocol EpisodesServicing {
    func fetchEpisodes(page: Int) async throws -> EpisodeResponse
}
