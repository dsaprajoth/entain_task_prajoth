//
//  NextRaceFilterTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

class AppUtilsTests: XCTestCase {

    // Test formatTime function for different time intervals
    func testFormatTime() {
        // Test for 0 seconds (should return 00d 00h 00m 00s)
        let result1 = AppUtils.formatTime(TimeInterval(0))
        XCTAssertEqual(result1, "0s")

        // Test for 3661 seconds (1 hour, 1 minute, 1 second)
        let result2 = AppUtils.formatTime(3661)
        XCTAssertEqual(result2, "1h 1m 1s")

        // Test for 86400 seconds (1 day)
        let result3 = AppUtils.formatTime(86400)
        XCTAssertEqual(result3, "1d 0s")

        // Test for 90061 seconds (1 day, 1 hour, 1 minute, 1 second)
        let result4 = AppUtils.formatTime(90061)
        XCTAssertEqual(result4, "1d 1h 1m 1s")
    }

    // Test convertEpochToDate function for different constant epoch times
    func testConvertEpochToDate() {
        // Recent date
        let epochTime1: TimeInterval = 1734211200 // Dec 15, 2024
        let result1 = AppUtils.convertEpochToDate(epochTime: epochTime1)
        let expectedDate1 = "15 Dec 2024 at 8:20 AM"
        XCTAssertEqual(result1, expectedDate1)

        // Leap year date
        let epochTime2: TimeInterval = 1582972800 // Feb 29, 2020
        let result2 = AppUtils.convertEpochToDate(epochTime: epochTime2)
        let expectedDate2 = "29 Feb 2020 at 9:40 PM"
        XCTAssertEqual(result2, expectedDate2)

        // Future date
        let epochTime3: TimeInterval = 1735708800 // Jan 1, 2025
        let result3 = AppUtils.convertEpochToDate(epochTime: epochTime3)
        let expectedDate3 = "1 Jan 2025 at 4:20 PM"
        XCTAssertEqual(result3, expectedDate3)
    }

    func testFetchRaceMockResponse_Success() {
        // Given
        // Mock data json exists in the bundle with the name "mock.json"
        
        // When
        let response = AppUtils.fetchRaceMockResponse()

        // Then
        XCTAssertNotNil(response, "nil")
        XCTAssertEqual(response?.status, 200)
    }
}


