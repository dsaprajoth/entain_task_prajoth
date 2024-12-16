//
//  RaceListViewUITests.swift
//  EntainTaskUITests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

import XCTest
@testable import EntainTask

class RaceListViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testRaceListDisplaysCorrectly() {
        // Create an expectation for the list to be populated
        let expectation = XCTestExpectation(description: "Race list should be populated")

        // Wait for the list to be populated or for an error condition
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let raceListTable = self.app.collectionViews["raceList"]

            // Check if race list exists
            XCTAssertTrue(raceListTable.exists, "The race list table should exist.")

            // Check race list has at least one item
            let raceCells = raceListTable.cells
            XCTAssertGreaterThan(raceCells.count, 0, "The race list should have at least one race.")

            // Verify that each race cell contains the correct elements. Assuming race cells have titles and countdowns.
            let firstRaceCell = raceCells.element(boundBy: 0)

            // Verify that the meeting name label is visible
            let raceMeetingNameLabel = firstRaceCell.staticTexts["raceMeetingNameLabel"]
            XCTAssertTrue(raceMeetingNameLabel.exists, "The race title label should be visible.")

            // Verify that the countdown timer label is visible
            let countdownLabel = firstRaceCell.staticTexts["countdownLabel"] 
            XCTAssertTrue(countdownLabel.exists, "The countdown timer label should be visible.")

            // Optionally, check that the countdown is not empty
            XCTAssertNotEqual(countdownLabel.label, "", "The countdown label should not be empty.")

            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled (timeout after 5 seconds)
        wait(for: [expectation], timeout: 5)
    }

}
