//
//  CharacterExportServicing.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

protocol CharacterExportServicing {
    func makeJson(from character: CharacterDetails) throws -> CharacterDetailsJson
    func makeDefaultFileName(from character: CharacterDetails) -> String
}
