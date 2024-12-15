//
//  MockNetworkManager.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import Foundation
import Combine
@testable import EntainTask

// This subclass of NetworkService is used to mock responses for testing ViewModels.
class MockNetworkManager<V>: NetworkService {
    var result: Result<V, Error>?

    func fetch<T: Decodable>(url: URL?, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        return result.publisher
            .flatMap { data -> Just<T> in
                Just(data as! T) // return the data as is
            }
            .eraseToAnyPublisher()
    }
}
