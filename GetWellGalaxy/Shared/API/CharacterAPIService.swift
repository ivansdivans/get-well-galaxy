//
//  CharacterAPIService.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

struct CharacterAPIService: CharacterServicing {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCharacter(id: Int) async throws -> CharacterDetails {
        guard let url = URL(string: "\(APIConfig.baseURLString)/character/\(id)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = APIConfig.defaultHTTPMethod
        
        let response: CharacterDetails = try await networkClient.request(request)
        return response
    }
}
