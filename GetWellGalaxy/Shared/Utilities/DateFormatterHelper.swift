//
//  DateFormatterHelper.swift
//  GetWellGalaxy
//
//  Created by Ivans Mihailovs on 27/02/2026.
//

import Foundation

enum DateFormatterHelper {
    private static let apiDateStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    private static let episodeAirDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    static func formattedDate(from rawValue: String) -> String? {
        guard let date = apiDateStringFormatter.date(from: rawValue) else { return nil }
        return episodeAirDateFormatter.string(from: date)
    }
}
