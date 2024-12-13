//
//  DataFetcher.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Foundation
import Combine

protocol DataFetcher {
    func fetchData() -> AnyPublisher<[RaceSummary], Error>
}

class RaceDataFetcher: DataFetcher {
    func fetchData() -> AnyPublisher<[RaceSummary], Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: APIConstants.endpoint)!)
            .map(\.data)
            .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
            .map { $0.data?.raceSummaries?.values.map { $0 } ?? [] }
            .eraseToAnyPublisher()
    }
}

class MockDataFetcher: DataFetcher {
    func fetchData() -> AnyPublisher<[RaceSummary], Error> {
        let data = loadJson()!
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func loadJson() -> [RaceSummary]? {
        if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NextRacesResponse.self, from: data)
                return jsonData.data?.raceSummaries?.values.map { $0 }
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
