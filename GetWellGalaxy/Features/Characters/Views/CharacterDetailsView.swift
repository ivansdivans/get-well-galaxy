//
//  CharacterDetailsView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import SwiftUI

struct CharacterDetailsView: View {
    let characterID: Int
    @State private var viewModel = CharacterDetailsViewModel(service: CharactersAPIService())
    
    var body: some View {
        VStack {
            Text("Character: \(viewModel.character?.name ?? "unknown")")
            Text("Is: \(viewModel.character?.status ?? "unknown")")
        }
        .navigationTitle("Character: \(characterID)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load(id: characterID)
        }
    }
}

#Preview {
    CharacterDetailsView(characterID: 1)
}
