//
//  CharacterCardRow.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 02/03/2026.
//

import SwiftUI

struct CharacterCardRow: View {
    let label: LocalizedStringResource
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
            Text(value)
                .font(.headline)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CharacterCardRow(label: "Name", value: "Cute Monster")
}
