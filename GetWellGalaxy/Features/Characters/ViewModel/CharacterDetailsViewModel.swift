//
//  CharacterDetailsViewModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation
import Observation

@MainActor
@Observable final class CharacterDetailsViewModel {
    private(set) var character: CharacterDetails?
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let service: CharacterServicing
    private let cacheStore: CharacterPersisting
    
    init(
        service: CharacterServicing,
        cacheStore: CharacterPersisting = CharacterSwiftDataStore.shared
    ) {
        self.service = service
        self.cacheStore = cacheStore
    }
    
    func loadIfNeeded(id: Int) async {
        guard !isLoading else {
            return
        }
        
        if character == nil {
            do {
                if let cached = try await cacheStore.loadCharacter(id: id) {
                    character = cached
                }
            } catch is CancellationError {
                return
            } catch {
                // Keep silent for mvp phase
            }
        }
        
        await load(id: id)
    }

    private func load(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try Task.checkCancellation()
            let response = try await service.fetchCharacter(id: id)
            character = response
            errorMessage = nil
            try await cacheStore.saveCharacter(response)
        } catch is CancellationError {
            return
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = String(localized: .errorCharacterFailedToLoad)
            }
        }
    }
    
    func retry(with id: Int) async {
        await load(id: id)
    }

    func clearError() {
        errorMessage = nil
    }
}
