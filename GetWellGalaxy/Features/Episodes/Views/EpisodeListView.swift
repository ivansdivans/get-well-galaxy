//
//  EpisodeListView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 25/02/2026.
//

import SwiftUI

struct EpisodeListView: View {
    @State private var viewModel = EpisodeListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.episodes) { episode in
                    NavigationLink {
                        EpisodeDetailView(episodeName: episode.name, characterURLs: episode.characters)
                    } label: {
                        EpisodeRowView(item: episode)
                    }
                }

                if !viewModel.isInitialLoading && !viewModel.episodes.isEmpty {
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
            .refreshable {
                await viewModel.refresh()
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
