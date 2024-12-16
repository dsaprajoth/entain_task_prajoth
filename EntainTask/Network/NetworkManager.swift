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
    case decodingFailed(String)
    case internetUnavailable
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
            return "Failed to decode the response: \(error)"
        case .internetUnavailable:
            return "The internet connection appears to be offline."
        case .unknown(let error):
            return error.localizedDescription.isEmpty ? "An unknown error occurred" : "\(error.localizedDescription)"
        }
    }
}

protocol NetworkService {
    func fetch<T: Decodable>(url: URL?, responseType: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkService {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable>(url: URL?, responseType: T.Type) -> AnyPublisher<T, Error> {
        // Validate the URL more strictly using URLComponents
        guard let url = url,
              let _ = URLComponents(url: url, resolvingAgainstBaseURL: false), // Ensure it's a valid URL component
              url.absoluteString.range(of: "^[a-zA-Z0-9+.-]+://", options: .regularExpression) != nil else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                // Check HTTP response status
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.unknown(URLError(.badServerResponse))
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.requestFailed(httpResponse.statusCode)
                }

                return output.data
            }
            .tryMap { data in
                // Check if the data is empty
                guard !data.isEmpty else {
                    throw NetworkError.noData
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // Map the error to a NetworkError
                if let urlError = error as? URLError {
                    if urlError.code == .notConnectedToInternet {
                        return NetworkError.internetUnavailable
                    }
                    return NetworkError.unknown(urlError)
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingFailed(decodingError.localizedDescription)
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

