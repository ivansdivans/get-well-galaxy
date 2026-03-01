//
//  EpisodesServiceMock.swift
//  GetWellGalaxyTests
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
@testable import GetWellGalaxy

final class EpisodesServiceMock: EpisodesServicing {
    var result: Result<EpisodeResponse, Error> = .failure(APIError.invalidResponse)
    private(set) var requestedPages: [Int] = []
    
    func fetchEpisodes(page: Int) async throws -> EpisodeResponse {
        requestedPages.append(page)
        return try result.get()
    }
}
