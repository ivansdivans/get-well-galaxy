//
//  DateFormatterHelperTests.swift
//  GetWellGalaxyTests
//
//  Created by Ivans Mihailovs on 02/03/2026.
//

import Testing
@testable import GetWellGalaxy

struct DateFormatterHelperTests {

    @Test func formattedDate_validApiDate_returnsCorrectDisplayDate() async throws {
        let result = DateFormatterHelper.formattedDate(from: "March 2, 2026")
        #expect(result == "02/03/2026")
    }

    @Test func formattedDate_invalidApiDate_returnsNil() {
        let result = DateFormatterHelper.formattedDate(from: "not-a-date")
        #expect(result == nil)
    }

}
