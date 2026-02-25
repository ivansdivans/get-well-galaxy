//
//  EpisodesAPIService.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation

struct EpisodesAPIService: EpisodesServicing {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchEpisodes(page: Int) async throws -> EpisodeResponse {
        guard var components = URLComponents(string: "\(APIConfig.baseURLString)/episode") else {
            throw APIError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: APIConfig.QueryItemName.page, value: String(page))
        ]
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = APIConfig.defaultHTTPMethod
        
        let response: EpisodeResponse = try await networkClient.request(request)
        return response
    }
}
