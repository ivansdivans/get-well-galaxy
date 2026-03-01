//
//  AppModelContainer.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation
import SwiftData

enum AppModelContainer {
    static let shared: ModelContainer = {
        do {
            return try ModelContainer(
                for: EpisodePersistenceModel.self,
                CharacterPersistenceModel.self
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
