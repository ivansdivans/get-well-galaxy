//
//  EpisodeRowView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 27/02/2026.
//

import SwiftUI

struct EpisodeRowView: View {
    let item: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            HStack {
                Text(item.episode)
                    .font(.subheadline)
                Text(formattedAirDate)
                    .font(.subheadline)
                    .italic()
            }
        }
    }
    
    private var formattedAirDate: String {
        DateFormatterHelper.formattedDate(from: item.airDate) ?? String(localized: .episodeRowUnknownAirDate)
    }
}

#Preview {
    EpisodeRowView(
        item: Episode(
            id: 123,
            name: "Example episode",
            airDate: "January 1, 2026",
            episode: "S0E0",
            characters: ["some-url-1", "some-url-2"]
        )
    )
}
