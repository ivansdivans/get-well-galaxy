//
//  CharacterDetailsView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import SwiftUI

struct CharacterDetailsView: View {
    let characterID: Int
    private let service: CharactersServicing = CharactersAPIService()
    
    @State private var character: CharacterDetails?
    
    var body: some View {
        VStack {
            Text("Id: \(characterID)")
            Text("Character: \(character?.name ?? "unknown")")
            Text("Is: \(character?.status ?? "unknown")")
        }
        .navigationTitle("Character: \(characterID)")
        .task {
            do {
                character = try await service.fetchCharacter(id: characterID)
            } catch {
                print("Character fetching error: \(error)")
            }
        }
    }
}

#Preview {
    CharacterDetailsView(characterID: 1)
}
