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
        List(characterIDs, id: \.self) { id in
            NavigationLink {
                CharacterDetailsView(characterID: id)
            } label: {
                HStack {
                    Image(systemName: "person.fill")
                    Text(.episodeDetailViewCharacter(id))
                }
            }
        }
        .navigationTitle(episodeName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var characterIDs: [Int] {
        CharacterHelper.getIDs(from: characterURLs)
    }
}

#Preview {
    EpisodeDetailView(
        episodeName: "Pilot episode",
        characterURLs: ["url-character-1", "url-character-2"]
    )
}
