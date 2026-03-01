//
//  EpisodeListViewModelTests.swift
//  GetWellGalaxyTests
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Testing
@testable import GetWellGalaxy

struct EpisodeListViewModelTests {

    @MainActor
    @Test func refresh_fetchesEpisodes() async throws {
        let service = EpisodesServiceMock()
        let episodes = [
            Episode(
                id: 1,
                name: "Good Afternoon, Good Evening and Good Night",
                airDate: "February 29, 2026",
                episode: "S01E01",
                characters: []
            ),
            Episode(
                id: 2,
                name: "Hello, my name is Forrest",
                airDate: "March 1, 2026",
                episode: "S01E02",
                characters: []
            )
        ]
        let response = EpisodeResponse(
            info: EpisodeInfo(count: episodes.count, pages: 1, next: nil, prev: nil),
            results: episodes
        )
        service.result = .success(response)
        
        let sut = EpisodeListViewModel(service: service)
        await sut.refresh()
        
        #expect(sut.episodes == episodes)
        #expect(sut.hasMorePages == false)
        #expect(sut.errorMessage == nil)
        #expect(service.requestedPages == [1])
    }

}
