//
//  APIError.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
    case otherError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .invalidStatusCode(let code):
            return "Invalid status code: \(code)."
        case .decodingFailed:
            return "Failed to decode response."
        case .otherError(let message):
            return message
        }
    }
}
