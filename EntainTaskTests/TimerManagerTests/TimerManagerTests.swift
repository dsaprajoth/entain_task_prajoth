//
//  TimerManagerTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

class TimerManagerTests: XCTestCase {

    var timerManager: TimerManager!
    var cancellable: AnyCancellable!

    override func setUp() {
        super.setUp()
        timerManager = TimerManager.shared
    }

    override func tearDown() {
        cancellable?.cancel()
        super.tearDown()
    }

    func testTimerUpdates() {
        // Given When - Shared instance of the Timer in the setUp()

        // Expectation
        let expectation = XCTestExpectation(description: "Timer updates every second")

        // Check if the timer is updating
        let expectedThreshold: Double = -1.0
        let tolerance: Double = 1 // Tolerance to tradeoff the timer floating point

        // Then - Subscribe to the timer and check that the currentTime updates.
        cancellable = TimerManager.shared.$currentTime
            .sink { currentTime in
                XCTAssertGreaterThan(currentTime.timeIntervalSinceNow + tolerance, expectedThreshold, "Timer should be updated")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5.0)
    }
}
