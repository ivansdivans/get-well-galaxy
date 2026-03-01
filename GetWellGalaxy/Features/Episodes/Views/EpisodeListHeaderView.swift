//
//  EpisodeListHeaderView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import SwiftUI

struct EpisodeListHeaderView: View {
    let lastRefreshedAt: Date?
    
    var body: some View {
        if let lastRefreshedAt {
            Text(
                .episodeListViewRefreshedAt(
                    lastRefreshedAt.formatted(date: .abbreviated, time: .shortened)
                )
            )
            .font(.footnote)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    EpisodeListHeaderView(lastRefreshedAt: Date())
}
