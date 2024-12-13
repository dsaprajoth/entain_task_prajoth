//
//  DataFetcher.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Foundation
import Combine

enum FailureReason: Error {
    case sessionFailed(error: URLError)
    case decodingFailed
    case other
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}

protocol DataFetcher {
    func fetchRaceData() -> AnyPublisher<NextRacesResponse, FailureReason>
}

class RaceDataFetcher: DataFetcher {
    private var cancellables = Set<AnyCancellable>()
    func fetchRaceData() -> AnyPublisher<NextRacesResponse, FailureReason> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: APIConstants.endpoint)!)
            .mapError { FailureReason.sessionFailed(error: $0) }
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    guard let response = response as? HTTPURLResponse else {
                        throw FailureReason.other
                    }
                    switch response.statusCode {
                    case 400...499:
                        throw FailureReason.internalError(response.statusCode)
                    default:
                        throw FailureReason.serverError(response.statusCode)
                    }
                }
                return data
            }
            .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
            .mapError { _ in
                return FailureReason.other
            }
            .eraseToAnyPublisher()
    }
}

class MockDataFetcher: DataFetcher {
    func fetchRaceData() -> AnyPublisher<NextRacesResponse, FailureReason> {
        let data = loadJson()
        return Just(data!)
            .setFailureType(to: FailureReason.self)
            .eraseToAnyPublisher()
    }
    func loadJson() -> NextRacesResponse? {
        if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NextRacesResponse.self, from: data)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }
}
