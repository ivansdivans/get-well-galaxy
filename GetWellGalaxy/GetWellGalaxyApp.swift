//
//  GetWellGalaxyApp.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 24/02/2026.
//

import SwiftUI

@main
struct GetWellGalaxyApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    // TODO: create private constant that holds data persistance store
    
    var body: some Scene {
        WindowGroup {
            EpisodeListView()
        }
        .onChange(of: scenePhase) { _, newScenePhase in
            if newScenePhase == .background {
                BackgroundRefreshScheduler.scheduleAppRefresh()
            }
        }
        .backgroundTask(.appRefresh(BackgroundRefreshConfig.taskIdentifier)) {
            let worker = EpisodesBackgroundRefreshWorker()
            _ = await worker.refreshAllEpisodes()
            
            BackgroundRefreshScheduler.scheduleAppRefresh()
        }
    }
}
