//
//  MockNetworkManager.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import Foundation
import Combine
@testable import EntainTask

// Allows injecting mock responses in tests. Supports returning successful or failed results based on the result property.
class MockNetworkManager<V>: NetworkService {
    var result: Result<V, Error>?

    func fetch<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        return result.publisher
            .flatMap { data -> Just<T> in
                Just(data as! T)
                // tryMap to help debugging decoding errors
//                    .tryMap { data in
//                        do {
//                            return try JSONDecoder().decode(T.self, from: data)
//                        } catch {
//                            print("Decoding Error: \(error)")
//                            print("Data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
//                            throw error
//                        }
//                    }
//                    .decode(type: T.self, decoder: JSONDecoder())
//                    .mapError { error in
//                        print("Decoding error: \(error.localizedDescription)")
//                        return NetworkError.decodingFailed(error)
//                    }
//                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
