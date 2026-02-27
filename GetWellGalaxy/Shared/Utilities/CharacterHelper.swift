//
//  CharacterHelper.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 27/02/2026.
//

import Foundation

enum CharacterHelper {
    static func id(from urlString: String) -> Int? {
        guard let url = URL(string: urlString),
              let lastComponent = url.pathComponents.last else {
            return nil
        }

        return Int(lastComponent)
    }

    static func getIDs(from urls: [String]) -> [Int] {
        urls.compactMap { urlString in
            id(from: urlString)
        }
    }
}
