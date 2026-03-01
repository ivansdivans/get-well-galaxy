//
//  CharacterPersisting.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

protocol CharacterPersisting {
    func loadCharacter(id: Int) async throws -> CharacterDetails?
    func saveCharacter(_ character: CharacterDetails) async throws
}
