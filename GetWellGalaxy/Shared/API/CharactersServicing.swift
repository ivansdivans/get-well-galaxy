//
//  CharactersServicing.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

protocol CharactersServicing {
    func fetchCharacter(id: Int) async throws -> CharacterDetails
}
