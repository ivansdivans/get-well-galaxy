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
        Group {
            if let character = viewModel.character {
                VStack {
                    Text("Character: \(character.name)")
                    Text("Is: \(character.status)")
                }
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                ContentUnavailableView(
                    "Character not available",
                    systemImage: "person.slash"
                )
            }
        }
        .navigationTitle("Character: \(characterID)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded(id: characterID)
        }
        .alert(
            .errorAlertTitle,
           isPresented: Binding(
               get: { viewModel.errorMessage != nil },
               set: { isPresented in
                   if isPresented == false { viewModel.clearError() }
               }
           ), actions: {
               Button(.errorAlertRetryButton) {
                   Task { await viewModel.retry(with: characterID) }
               }
               Button(.errorAlertCancelButton, role: .cancel) {
                   viewModel.clearError()
               }
           }, message: {
               Text(viewModel.errorMessage ?? "")
           }
        )
    }
}

#Preview {
    CharacterDetailsView(characterID: 1)
}
