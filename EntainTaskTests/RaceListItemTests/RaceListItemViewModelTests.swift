//
//  RaceListItemViewModelTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

class RaceListItemViewModelTests: XCTestCase {
    var viewModel: RaceListItemViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testTimeRemainingStringUpdatesCorrectly() {
        // Given
        let advertisedStartTime = Date().addingTimeInterval(120).timeIntervalSince1970 // 2 minutes from now
        let mockRace: RaceSummary = .init(raceID: "1",
                                          raceName: "Test Race",
                                          raceNumber: 2,
                                          meetingID: "meeting1",
                                          meetingName: "Test Race Meeting",
                                          categoryID: RaceType.horseRacing.categoryId,
                                          advertisedStart: .init(
                                            seconds: Int(advertisedStartTime)),
                                          raceForm: nil,
                                          venueID: "venue1",
                                          venueName: "Test Venue",
                                          venueState: "Test State",
                                          venueCountry: "USA")

        // When
        viewModel = RaceListItemViewModel(race: mockRace)

        // Then
        let expectation = XCTestExpectation(description: "Time remaining string updates correctly")
        viewModel.$timeRemainingString
            .sink { timeString in
                if !timeString.isEmpty {
                    /// Seconds component may vary by the time the test runs, so we'll just check for the '1m' component
                    /// assuming the test runs within a minute and 10 seconds of the advertised start time.
                    /// In practice by the time test runs, the time remaining string ideally is 1m 58s
                    XCTAssertNotNil(timeString.range(of:"1m 5"), "Time remaining string should contain '1m 5'.")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testTimeRemaining() {
        // Given
        let advertisedStartTime = Date().addingTimeInterval(60).timeIntervalSince1970 // 2 minutes from now
        let mockRace: RaceSummary = .init(raceID: "1",
                                          raceName: "Test Race",
                                          raceNumber: 2,
                                          meetingID: "meeting1",
                                          meetingName: "Test Race Meeting",
                                          categoryID: RaceType.horseRacing.categoryId,
                                          advertisedStart: .init(
                                            seconds: Int(advertisedStartTime)),
                                          raceForm: nil,
                                          venueID: "venue1",
                                          venueName: "Test Venue",
                                          venueState: "Test State",
                                          venueCountry: "USA")
        viewModel = RaceListItemViewModel(race: mockRace)
        let currentTime = Date()

//        // When
//        viewModel.updateTimeRemaining(currentTime: currentTime)
//
//        // Then
//        XCTAssertEqual(viewModel.timeRemainingString, "1m 0s", "The time remaining should be 1 minute")

        // When
        // Simulate 1 minute passing
        let updatedTime = Date().addingTimeInterval(60)
        viewModel.updateTimeRemaining(currentTime: updatedTime)

        // Then
        XCTAssertEqual(viewModel.timeRemainingString, "0s", "The timer should show 0 seconds after 1 minute")
    }

    func testIsTimerFinishedUpdatesCorrectly() {
        // Given
        let advertisedStartTime = Date().addingTimeInterval(-61).timeIntervalSince1970 // 61 seconds in the past
        let mockRace: RaceSummary = .init(raceID: "1",
                                          raceName: "Test Race",
                                          raceNumber: 2,
                                          meetingID: "meeting1",
                                          meetingName: "Test Race Meeting",
                                          categoryID: RaceType.horseRacing.categoryId,
                                          advertisedStart: .init(
                                            seconds: Int(advertisedStartTime)),
                                          raceForm: nil,
                                          venueID: "venue1",
                                          venueName: "Test Venue",
                                          venueState: "Test State",
                                          venueCountry: "USA")

        // When
        viewModel = RaceListItemViewModel(race: mockRace)
        viewModel.updateTimeRemaining(currentTime: Date())

        // Then
        XCTAssertTrue(viewModel.isTimerFinished, "The isTimerFinished property should be true when time interval is less than -60 seconds.")
    }

    func testColorForTimeRemaining() {
        // Given
        // Test upcoming race (green)
        viewModel = RaceListItemViewModel(race: RaceMockData.upcomingRace)
        // THen
        XCTAssertEqual(viewModel.colorForTimeRemaining, .green, "Upcoming race should have a green color.")

        // Given
        // Test nearly started race (orange)
        viewModel = RaceListItemViewModel(race: RaceMockData.nearlyStartedRace)
        // THen
        XCTAssertEqual(viewModel.colorForTimeRemaining, .orange, "Nearly started race should have an orange color.")

        // Given
        // Test past race (red)
        viewModel = RaceListItemViewModel(race: RaceMockData.pastRace)
        // THen
        XCTAssertEqual(viewModel.colorForTimeRemaining, .red, "Past race should have a red color.")
    }

    func testMeetingName() {
        // Given
        viewModel = RaceListItemViewModel(race: RaceMockData.mockRace)

        // Then
        XCTAssertEqual(viewModel.meetingName, "Test Race Meeting", "Meeting name should match the race's meeting name.")
    }

    func testRaceNumberFormatting() {
        // Given
        viewModel = RaceListItemViewModel(race: RaceMockData.mockRace)

        // Then
        XCTAssertEqual(viewModel.raceNumber, "R2", "Race number should be formatted as 'R{number}'.")
    }

    func testVenueCountry() {
        // Given
        viewModel = RaceListItemViewModel(race: RaceMockData.mockRace)

        // Then
        XCTAssertEqual(viewModel.venue, "USA", "Venue country should match the race's venue country.")
    }
}
