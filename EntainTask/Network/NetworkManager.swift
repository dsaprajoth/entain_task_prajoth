//
//  NetworkLayer.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import Foundation
import Combine

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(Int) // HTTP status codes
    case noData
    case decodingFailed(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .noData:
            return "No data was received from the server."
        case .decodingFailed(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

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
            .tryCatch { error -> AnyPublisher<Data, Error> in
                // If there is an error in the network layer, return a custom error
                if let urlError = error as? URLError {
                    throw NetworkError.unknown(urlError)
                }
                throw error
            }
            .flatMap { data in
                // Attempt to decode the data
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        return NetworkError.decodingFailed(error)
                    }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

//            .decode(type: T.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
}

