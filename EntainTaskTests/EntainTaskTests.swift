////
////  EntainTaskTests.swift
////  EntainTaskTests
////
////  Created by Prajoth Dsa on 13/12/2024.
////
//
//import XCTest
//import Combine
//@testable import EntainTask
//
//class NextRaceViewModelTests: XCTestCase {
//    func testFetchData() {
//        // Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Data fetched and decoded successfully")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let data = viewModel.raceListFromAPI
//            if !data.isEmpty {
//                XCTAssertNotNil(data, "Data should not be nil")
//                XCTAssertEqual(data.count, 5)
//                expectation.fulfill()
//            } else {
//                XCTFail("Failed to fetch data")
//            }
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//        
//    func testHorseRacingFilter() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for Horse racing")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            if viewModel.raceListFromAPI.isEmpty {
//                XCTFail("Failed to fetch data")
//                return 
//            }
//            viewModel.filter(by: .horseRacing)
//            let filteredData = viewModel.nextRaceList
//            XCTAssertNotNil(filteredData, "Data should not be nil")
//            XCTAssertEqual(filteredData.count, 2)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//    
//    func testHarnessRacingFilter() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for Harness racing")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            if viewModel.raceListFromAPI.isEmpty {
//                XCTFail("Failed to fetch data")
//                return
//            }
//            viewModel.filter(by: .harnessRacing)
//            let filteredData = viewModel.nextRaceList
//            XCTAssertNotNil(filteredData, "Data should not be nil")
//            XCTAssertEqual(filteredData.count, 1)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//    
//    func testGreyhoundRacingFilter() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for Greyhound racing")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            if viewModel.raceListFromAPI.isEmpty {
//                XCTFail("Failed to fetch data")
//                return
//            }
//            viewModel.filter(by: .greyHoundRacing)
//            let filteredData = viewModel.nextRaceList
//            XCTAssertNotNil(filteredData, "Data should not be nil")
//            XCTAssertEqual(filteredData.count, 2)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//    
//    func testClearFilterWhenSameFilterClickedTwice() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for Greyhound racing")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            if viewModel.raceListFromAPI.isEmpty {
//                XCTFail("Failed to fetch data")
//                return
//            }
//            viewModel.filter(by: .greyHoundRacing)
//            viewModel.filter(by: .greyHoundRacing)
//            let filteredData = viewModel.nextRaceList
//            XCTAssertNotNil(filteredData, "Data should not be nil")
//            XCTAssertEqual(viewModel.selectedFilters.count, 0)
//            XCTAssertEqual(filteredData.count, 5)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//    
//    func testRaceSummaryComputedProperties() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for horse race")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let data = viewModel.raceListFromAPI
//            if !data.isEmpty {
//                if let firstRaceObj = data.first(where: { $0.raceID == "1b27039b-e4d4-479d-beba-72cffd1186fb" }) {
//                    XCTAssertNotNil(firstRaceObj, "Data should not be nil")
//                    XCTAssertEqual(firstRaceObj.advertisedStartValue, 172800)
//                    XCTAssertEqual(firstRaceObj.raceTitleAccessibility, "Meeting \(firstRaceObj.meetingName ?? "") Race \(firstRaceObj.raceNumber ?? 0) Starting in 10 mins")
//                    expectation.fulfill()
//                } else {
//                    XCTFail("Failed to fetch data")
//                }
//            } else {
//                XCTFail("Failed to fetch data")
//            }
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//    
//    func testUtilConversionOfSecondsToReadableFormat() {
//        //Given
//        let mockDataFetcher = MockDataFetcher()
//        let viewModel = NextRaceViewModel(dataFetcher: mockDataFetcher)
//        let expectation = expectation(description: "Verify filter functionality for horse race")
//
//        // When
//        viewModel.fetchData()
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let data = viewModel.raceListFromAPI
//            if !data.isEmpty {
//                if let firstRaceObj = data.first(where: { $0.raceID == "1b27039b-e4d4-479d-beba-72cffd1186fb" }) {
//                    if let seconds = firstRaceObj.advertisedStart?.seconds {
//                        XCTAssertEqual(AppUtils().formatTime(seconds), "2d 0s")
//                        expectation.fulfill()
//                    }
//                } else {
//                    XCTFail("Failed to fetch data")
//                }
//            } else {
//                XCTFail("Failed to fetch data")
//            }
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//
//}
