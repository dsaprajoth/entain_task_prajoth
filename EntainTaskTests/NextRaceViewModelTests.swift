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

    override func setUp() {
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

    func testFetchData_Success() {
        let mockData = AppUtils.loadJsonData()!
        mockNetworkManager.result = .success(mockData)

        let expectation = XCTestExpectation(description: "Fetch data")

        viewModel.$nextRaceList
            .dropFirst()
            .sink { data in
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData()

        wait(for: [expectation], timeout: 1.0)
    }

//    func testFetchData_Failure() {
//        mockNetworkManager.result = .failure(URLError(.notConnectedToInternet))
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
