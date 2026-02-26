//
//  EpisodeListView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import SwiftUI

struct EpisodeListView: View {
    @State private var viewModel = EpisodeListViewModel(service: EpisodesAPIService())
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.episodes) { episode in
                    Text(episode.name)
                }

                if !viewModel.isInitialLoading {
                    EpisodePaginationFooterView(
                        isLoadingMore: viewModel.isLoadingMore,
                        hasMorePages: viewModel.hasMorePages,
                        loadNextPage: { await viewModel.loadNextPage() }
                    )
                }
            }
            .navigationTitle(.episodeListViewTitle)
            .task {
                await viewModel.loadInitialIfNeeded()
            }
            .alert(
                .errorAlertTitle,
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.clearError() } }
                ), actions: {
                    Button(.errorAlertRetryButton) {
                        Task { await viewModel.retry() }
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
}

#Preview {
    EpisodeListView()
}
