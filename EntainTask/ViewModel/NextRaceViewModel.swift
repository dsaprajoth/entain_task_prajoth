//
//  NextRaceVM.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Combine
import Foundation

class NextRaceViewModel: ObservableObject {
    var raceListFromAPI: [RaceSummary]?
    @Published var nextRaceList: [RaceSummary] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    var selectedFilters: [RaceType] = []
    private let dataFetcher: DataFetcher
    private var cancellable: AnyCancellable?
    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
    }
    func fetchData(mock: Bool = false) {
        if mock {
            self.raceListFromAPI = loadJson() ?? []
            self.nextRaceList = loadJson() ?? []
            return
        }
        self.isLoading = true
        cancellable = dataFetcher.fetchRaceData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    switch error {
                    case .sessionFailed(let error):
                        self.errorMessage = error.localizedDescription
                    case .decodingFailed:
                        self.errorMessage = "Decoding failed"
                    case .other:
                        self.errorMessage = "Error occured while fetching data"
                    case .internalError(let error):
                        self.errorMessage = "Internal Server Error: \(error)"
                    case .serverError(let error):
                        self.errorMessage = "Server Error: \(error)"
                    }
                case .finished:
                    print("Data fetched successfully")
                }
            } receiveValue: { data in
                self.raceListFromAPI = data.data?.raceSummaries?.values.map { $0 }
                self.nextRaceList = data.data?.raceSummaries?.values.map { $0 } ?? []
            }
    }
    func filter(by raceType: RaceType) {
        if selectedFilters.contains(raceType) {
            selectedFilters.removeAll { $0 == raceType }
        } else {
            selectedFilters.append(raceType)
        }
        if selectedFilters.isEmpty {
            self.nextRaceList = raceListFromAPI ?? []
        } else {
            let raceCategoryIds = selectedFilters.map { $0.categoryId }
            self.nextRaceList = raceListFromAPI?.filter { raceCategoryIds.contains($0.categoryID ?? "") } ?? []
        }
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
