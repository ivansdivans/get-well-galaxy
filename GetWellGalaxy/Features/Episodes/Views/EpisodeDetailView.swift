//
//  EpisodeDetailView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 27/02/2026.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episodeName: String
    let characterURLs: [String]
    
    var body: some View {
        List(characterURLs, id: \.self) { character in
            Text(character)
        }
        .navigationTitle(episodeName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EpisodeDetailView(
        episodeName: "Pilot episode",
        characterURLs: ["url-character-1", "url-character-2"]
    )
}
