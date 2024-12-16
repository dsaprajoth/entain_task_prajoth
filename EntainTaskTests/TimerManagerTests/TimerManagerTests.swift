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

        // Then - Subscribe to the timer and check that the currentTime updates.
        cancellable = TimerManager.shared.$currentTime
            .sink { currentTime in
                XCTAssertGreaterThan(currentTime.timeIntervalSinceNow, -1, "Timer should be updated")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2.0) // Wait for a couple of seconds for the timer to update
    }
}
