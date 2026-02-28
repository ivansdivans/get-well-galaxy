//
//  CharacterDetailsViewModel.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import Foundation

@Observable final class CharacterDetailsViewModel {
    private(set) var character: CharacterDetails?
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let service: CharactersServicing
    
    init(service: CharactersServicing) {
        self.service = service
    }
    
    func loadIfNeeded(id: Int) async {
        guard character == nil, !isLoading else { return }
        await load(id: id)
    }

    private func load(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try Task.checkCancellation()
            let reponse = try await service.fetchCharacter(id: id)
            
            character = reponse
            errorMessage = nil
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
