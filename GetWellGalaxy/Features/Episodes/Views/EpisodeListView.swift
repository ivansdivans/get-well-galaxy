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
            List(viewModel.episodes) { episode in
                Text(episode.name)
            }
            .navigationTitle(.episodeListViewTitle)
            .task {
                await viewModel.loadInitialIfNeeded()
            }
        }
    }
}

#Preview {
    EpisodeListView()
}
