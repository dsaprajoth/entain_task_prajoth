//
//  NextRaceViewModelTests.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//
import XCTest
import Combine
@testable import EntainTask

class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        cancellables = Set<AnyCancellable>()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
        cancellables = nil
    }
    
//    func test_with_successful_response_response_is_valid() throws {
//        let mockData = AppUtils.loadJsonData()
//
//        guard   let data = mockData else {
//            XCTFail("Failed to get the mock file")
//            return
//        }
//
////        let decoder = JSONDecoder()
////        let mockResponse = try? decoder.decode(NextRacesResponse.self, from: data)
//
//        MockURLSessionProtocol.loadingHandler = {
//            let response = HTTPURLResponse(url: self.url,
//                                           statusCode: 200,
//                                           httpVersion: nil,
//                                           headerFields: nil)
//            return (response!, mockData)
//        }
//
//        let expectation = XCTestExpectation()
//
//        let networkManager = NetworkManager(urlSession: session)
//        networkManager.fetch(url: url, responseType: NextRacesResponse.self)
//            .sink(receiveCompletion: {  value in
//            }, receiveValue: { response in
//                XCTAssertEqual(mockResponse, response, "The returned response should be decoded properly")
//                expectation.fulfill()
//            }) .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5)
//    }


//    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() {
//
//        let invalidStatusCode = 404
//
//        MockURLSessionProtocol.loadingHandler = {
//            let response = HTTPURLResponse(url: self.url,
//                                           statusCode: invalidStatusCode,
//                                           httpVersion: nil,
//                                           headerFields: nil)
//            return (response!, nil)
//        }
//
//        let expectation = XCTestExpectation()
//
//        let networkManager = NetworkManager(urlSession: session)
//        networkManager.fetch(url: url, responseType: NextRacesResponse.self)
//            .sink(receiveCompletion: {  response in
//                switch response {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                    expectation.fulfill()
//                }
//            }, receiveValue: { response in
//                print(response)
//            }).store(in: &cancellables)
//        wait(for: [expectation], timeout: 5)
//    }

}


