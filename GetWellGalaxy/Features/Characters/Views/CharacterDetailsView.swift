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
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: character.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else if phase.error != nil {
                            Image(systemName: "person.crop.square.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(height: 300)
                    
                    Text(.characterDetailsViewName(character.name))
                    Text(.characterDetailsViewOrigin(character.origin.name))
                    Text(.characterDetailsViewSpecies(character.species))
                    Text(.characterDetailsViewStatus(character.status))
                    Text(.characterDetailsViewEpisodes(character.episode.count))
                    Spacer()
                }
                .padding(.horizontal, 30)
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                ContentUnavailableView(
                    .characterDetailsViewUnavailable,
                    systemImage: "person.slash"
                )
            }
        }
        .navigationTitle(.characterDetailsViewNavTitle(characterID))
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
