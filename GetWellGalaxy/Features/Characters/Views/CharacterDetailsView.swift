//
//  CharacterDetailsView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 28/02/2026.
//

import SwiftUI
import UniformTypeIdentifiers

struct CharacterDetailsView: View {
    let characterID: Int
    private let exportService: CharacterExportServicing = CharacterExportService()
    
    @State private var viewModel = CharacterDetailsViewModel(service: CharacterAPIService())
    @State private var isExporting = false
    @State private var exportDocument = CharacterDetailsJson(data: Data())
    @State private var exportFileName = "character"
    @State private var exportErrorMessage: String?

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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    prepareExport()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .disabled(viewModel.character == nil)
            }
        }
        .task {
            await viewModel.loadIfNeeded(id: characterID)
        }
        .fileExporter(
            isPresented: $isExporting,
            document: exportDocument,
            contentType: .json,
            defaultFilename: exportFileName
        ) { result in
            switch result {
            case .success(let url):
                print("Character saved to \(url)")
            case .failure(let error):
                exportErrorMessage = error.localizedDescription
            }
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
        .alert(
            .errorAlertTitle,
            isPresented: Binding(
                get: { exportErrorMessage != nil },
                set: { isPresented in
                    if isPresented == false { exportErrorMessage = nil }
                }
            ), actions: {
                Button(.errorAlertDefaultButton, role: .cancel) {
                    exportErrorMessage = nil
                }
            }, message: {
                Text(exportErrorMessage ?? "")
            }
        )
    }
    
    private func prepareExport() {
        guard let character = viewModel.character else { return }

        do {
            exportDocument = try exportService.makeJson(from: character)
            exportFileName = exportService.makeDefaultFileName(from: character)
            isExporting = true
        } catch {
            exportErrorMessage = error.localizedDescription
        }
    }
}

#Preview {
    CharacterDetailsView(characterID: 1)
}
