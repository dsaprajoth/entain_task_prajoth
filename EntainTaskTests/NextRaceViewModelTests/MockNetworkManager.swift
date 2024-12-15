//
//  MockNetworkManager.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import Foundation
import Combine
@testable import EntainTask

/// This subclass of NetworkService is used to mock responses for testing ViewModels.
/// It returns the provided result as a publisher. Hence can be used to mock any response type.
/// For this task we are using it to mock responses for the NextRaceViewModel
class MockNetworkManager<V>: NetworkService {
    var result: Result<V, Error>?

    func fetch<T: Decodable>(url: URL?, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        return result.publisher
            .flatMap { data -> Just<T> in
                // return the data as is
                Just(data as! T)
            }
            .eraseToAnyPublisher()
    }
}
