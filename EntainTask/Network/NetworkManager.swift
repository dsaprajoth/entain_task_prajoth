//
//  NetworkLayer.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import Foundation
import Combine

// Defines the contract for fetching data. This will be implemented by the NetworkManager or MockNetworkManager
protocol NetworkService {
    func fetch<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error>
}

// Implements the NetworkService protocol using URLSession and Combine to fetch and decode data.
class NetworkManager: NetworkService {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error> {
        urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// Allows injecting mock responses in tests. Supports returning successful or failed results based on the result property.
class MockNetworkManager: NetworkService {
    var result: Result<Data, Error>?

    func fetch<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        return result.publisher
            .flatMap { data -> AnyPublisher<T, Error> in
                Just(data)
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
                    .decode(type: T.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
