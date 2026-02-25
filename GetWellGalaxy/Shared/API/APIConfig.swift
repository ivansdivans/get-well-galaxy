//
//  APIConfig.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import Foundation

enum APIConfig {
    static let baseURLString = "https://rickandmortyapi.com/api"
    static let defaultHTTPMethod = "GET"
    
    enum QueryItemName {
        static let page = "page"
    }
}
