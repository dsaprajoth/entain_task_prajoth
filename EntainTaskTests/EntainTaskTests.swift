//
//  EntainTaskTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

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
//            if let data = viewModel.raceListFromAPI {
//                XCTAssertNotNil(data, "Data should not be nil")
//                XCTAssertEqual(data.count, 2)
//                expectation.fulfill()
//            } else {
//                XCTFail("Failed to fetch data")
//            }
//        }
//
//        waitForExpectations(timeout: 5)
//    }
//}
