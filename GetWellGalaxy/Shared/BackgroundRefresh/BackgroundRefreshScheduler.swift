//
//  BackgroundRefreshScheduler.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import BackgroundTasks
import Foundation

enum BackgroundRefreshScheduler {
    static func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: BackgroundRefreshConfig.taskIdentifier)
        request.earliestBeginDate = .now.addingTimeInterval(BackgroundRefreshConfig.earliestBeginInterval)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            // Keep silent for mvp phase
        }
    }
}
