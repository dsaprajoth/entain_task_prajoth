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
    var mockNetworkManager: MockNetworkManager<Any>!
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
        let mockData = AppUtils.fetchRaceMockResponse()

        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data success")

        // When
        viewModel.fetchData()

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(data.count, 5)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
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

    @MainActor func testFetchData_RequestFailed() {
        mockNetworkManager.result = .failure(NetworkError.requestFailed(404))

        let expectation = XCTestExpectation(description: "Handle status code 404")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Request failed with status code 404.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData()

        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor func testFilterByHorseRace() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data & filter by horse racing")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .horseRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(data.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    @MainActor func testFilterByHarnessRace() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data & filter by harness racing")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .harnessRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(data.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }

    @MainActor func testFilterByGreyhoundRace() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data & filter by greyhound racing")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .greyHoundRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }

    @MainActor func testFilterCombinationHorseAndGreyhoundRacing() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data & filter by horse and greyhound racing")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .horseRacing)
        viewModel.filter(by: .greyHoundRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(self.viewModel.selectedFilters.count, 2)
                XCTAssertEqual(data.count, 3)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    @MainActor func testFilterCombinationHorseAndHarnessRacing() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .horseRacing)
        viewModel.filter(by: .harnessRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(self.viewModel.selectedFilters.count, 2)
                XCTAssertEqual(data.count, 4)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }


    @MainActor func testClearFilterWhenSameFilterClickedTwice() {
        // Given
        let mockData = AppUtils.fetchRaceMockResponse()
        mockNetworkManager.result = .success(mockData!)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch data")

        // When
        viewModel.fetchData()
        viewModel.filter(by: .greyHoundRacing)
        viewModel.filter(by: .greyHoundRacing)

        // Then
        viewModel.$nextRaceList
            .sink { data in
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(self.viewModel.selectedFilters.count, 0)
                XCTAssertEqual(data.count, 5)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
