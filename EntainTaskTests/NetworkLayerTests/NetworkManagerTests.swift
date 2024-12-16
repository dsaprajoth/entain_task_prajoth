//
//  NetworkManagerTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

import XCTest
import Combine
@testable import EntainTask

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        networkManager = NetworkManager(urlSession: urlSession)
        cancellables = []
    }

    override func tearDown() {
        networkManager = nil
        MockURLProtocol.responseData = nil
        MockURLProtocol.responseError = nil
        MockURLProtocol.response = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetch_Success() {
        // Given
        let mockURL = URL(string: "https://entain.fetchraces/mock/doesnothing")!
        let expectedData = """
        {
            "raceNum": 1,
            "meetingName": "Test Resource"
        }
        """.data(using: .utf8)!

        // When
        MockURLProtocol.responseData = expectedData
        MockURLProtocol.response = HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)

        // Expectation
        let expectation = XCTestExpectation(description: "Fetch succeeds")

        // Then
        networkManager.fetch(url: mockURL, responseType: MockRaceModel.self)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but received failure")
                }
            }, receiveValue: { value in
                XCTAssertEqual(value.raceNum, 1)
                XCTAssertEqual(value.meetingName, "Test Resource")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetch_InvalidURL() {
        // Given
        let invalidURL = URL(string: "invalid-url")!

        // When
        let expectation = XCTestExpectation(description: "Fetch fails with invalid URL")
        networkManager.fetch(url: invalidURL, responseType: MockRaceModel.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is NetworkError)
                    XCTAssertEqual(error.localizedDescription, NetworkError.invalidURL.errorDescription)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but received success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetch_DecodingFailure() {
        // Given
        let mockURL = URL(string: "https://mockapi.com/resource")!
        let invalidData = "Invalid JSON".data(using: .utf8)!
        MockURLProtocol.responseData = invalidData
        MockURLProtocol.response = HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let expectation = XCTestExpectation(description: "Fetch fails with decoding error")
        networkManager.fetch(url: mockURL, responseType: MockRaceModel.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is NetworkError)
                    XCTAssertEqual(error.localizedDescription, "Failed to decode the response: The data couldn’t be read because it isn’t in the correct format.")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but received success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }

    func testFetch_NoData() {
        // Given
        let mockURL = URL(string: "https://mockapi.com/resource")!
        MockURLProtocol.responseData = nil
        MockURLProtocol.response = HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let expectation = XCTestExpectation(description: "Fetch fails with no data")
        networkManager.fetch(url: mockURL, responseType: MockRaceModel.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is NetworkError)
                    XCTAssertEqual(error.localizedDescription, NetworkError.noData.errorDescription)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but received success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
