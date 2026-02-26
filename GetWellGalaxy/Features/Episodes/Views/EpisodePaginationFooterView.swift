//
//  EpisodePaginationFooterView.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 26/02/2026.
//

import SwiftUI

struct EpisodePaginationFooterView: View {
    let isLoadingMore: Bool
    let hasMorePages: Bool
    let loadNextPage: () async -> Void

    var body: some View {
        if isLoadingMore {
            footerRow
        } else if hasMorePages {
            footerRow
                .onAppear {
                    Task { await loadNextPage() }
                }
        }
    }

    private var footerRow: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    EpisodePaginationFooterView(
        isLoadingMore: false,
        hasMorePages: true,
        loadNextPage: { }
    )
}
