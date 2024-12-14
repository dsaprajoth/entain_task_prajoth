//
//  NextRaceViewModelTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

class NextRaceViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var mockNetworkManager: MockNetworkManager!
    var viewModel: NextRaceViewModel!

    @MainActor override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkManager = MockNetworkManager()
        viewModel = NextRaceViewModel(networkService: mockNetworkManager)
    }

    override func tearDown() {
        cancellables = nil
        mockNetworkManager = nil
        viewModel = nil
        super.tearDown()
    }

    @MainActor 
    func testFetchData_Success() {
        // Given
        let mockData = AppUtils.loadJsonData()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data")

        // When
        viewModel.fetchData()

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertEqual(data.count, 5)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 8.0)
    }

    @MainActor func testFetchData_Failure() {
        mockNetworkManager.result = .failure(URLError(.notConnectedToInternet))

        let expectation = XCTestExpectation(description: "Handle error")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, URLError(.notConnectedToInternet).localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData()

        wait(for: [expectation], timeout: 1.0)
    }

//    @MainActor func testFetchData_Failure() {
//        mockNetworkManager.result = .failure(.decodingFailed)
//
//        let expectation = XCTestExpectation(description: "Handle error")
//
//        viewModel.$errorMessage
//            .dropFirst()
//            .sink { errorMessage in
//                XCTAssertEqual(errorMessage, URLError(.notConnectedToInternet).localizedDescription)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//
//        viewModel.fetchData()
//
//        wait(for: [expectation], timeout: 1.0)
//    }
}
