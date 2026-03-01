//
//  BackgroundRefreshConfig.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 01/03/2026.
//

import Foundation

enum BackgroundRefreshConfig {
    static let taskIdentifier = "com.ivansdivans.GetWellGalaxy.episodeslist.refresh"
    /// Background app refresh task time interval
    /// currently set to unusually small value - 22 minutes.
    /// Creator of this app uderstands that normal interval should be ~24h,
    /// however this is a pet-project and 22 minutes is a signifficant value.
    /// Every "Rick and Morty" episode lasts around 22 minutes.
    /// During these 22 minutes the whole galaxies are born and destroyes,
    /// many lives are lived and regretted, so one might argue
    /// that "22 minutes" is a too long time to trigger background data refresh.
    static let earliestBeginInterval: TimeInterval = 22 * 60
}
