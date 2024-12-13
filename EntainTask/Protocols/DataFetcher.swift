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
    case other(Error)
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
                    switch (response as! HTTPURLResponse).statusCode {
                    case (400...499):
                        throw FailureReason.internalError((response as! HTTPURLResponse).statusCode)
                    default:
                        throw FailureReason.serverError((response as! HTTPURLResponse).statusCode)
                    }
                }
                return data
            }
//            .map(\.data)
            .flatMap { output in
                Just(output)
                    .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
                    .mapError { _ in return FailureReason.decodingFailed }
                    .eraseToAnyPublisher()
            }
//            .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return error as! FailureReason
            }
            .eraseToAnyPublisher()
        
    }
        //        return URLSession.shared.dataTaskPublisher(for: URL(string: APIConstants.endpoint)!)
        //            .mapError { APIError.networkError($0) } // Handle network errors
        //            .flatMap { output in
        //                Just(output.data)
        //                    .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
        //                    .mapError { _ in APIError.decodingError } // Handle decoding errors
        //            }
        //            .map { $0.data?.raceSummaries?.values.map { $0 } ?? [] }
        //            .eraseToAnyPublisher()
        
        //            .map(\.data)
        //            .mapError { error in
        //                return APIError.decodingError(error: error)
        //            }
        //            .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
        //            .tryMap { $0.data?.raceSummaries?.values.map { $0 } ?? [] }
        ////            .map { $0.data?.raceSummaries?.values.map { $0 } ?? [] }
        //            .eraseToAnyPublisher()
        //    }
    }

//class MockDataFetcher: DataFetcher {
//    func fetchRaceData() -> AnyPublisher<[RaceSummary]?, FailureReason> {
//        let data = loadJson()!
//        return Just(data)
//            .setFailureType(to: FailureReason.self)
//            .eraseToAnyPublisher()
//    }
//    func loadJson() -> [RaceSummary]? {
//        if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(NextRacesResponse.self, from: data)
//                return jsonData.data?.raceSummaries?.values.map { $0 }
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//}
