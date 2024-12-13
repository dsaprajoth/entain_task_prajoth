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
        
        cancellable = dataFetcher.fetchData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    print("Data fetched successfully")
                }
            } receiveValue: { data in
                self.raceListFromAPI = data
                self.nextRaceList = data
            }
        
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: NextRacesResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink {  [weak self] completion in
//                self?.isLoading = false
//                switch completion {
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    print("Error fetching data: \(error)")
//                case .finished:
//                    print("Data fetched successfully")
//                }
//            } receiveValue: { data in
//                self.data = data
//                self.nextRaceList = data.data?.raceSummaries?.values.map { $0 } ?? []
//                self.nextRaceList.sort { $0.advertisedStart?.seconds ?? 0 < $1.advertisedStart?.seconds ?? 0 }
//            }
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
            self.nextRaceList = raceListFromAPI?.filter { selectedFilters.map { $0.getRaceTypeId() }.contains($0.categoryID ?? "") } ?? []
        }
    }
    
    func getRaceType(from categoryId: String) -> String {
        switch categoryId {
        case RaceType.horseRacing.getRaceTypeId():
            return RaceType.horseRacing.rawValue
        case RaceType.harnessRacing.getRaceTypeId():
            return RaceType.harnessRacing.rawValue
        case RaceType.greyHoundRacing.getRaceTypeId():
            return RaceType.greyHoundRacing.rawValue
        default:
            return ""
        }
    }
    
    func getRaceIcon(from categoryId: String) -> String {
        switch categoryId {
        case RaceType.horseRacing.getRaceTypeId():
            return "horse"
        case RaceType.harnessRacing.getRaceTypeId():
            return "harness"
        case RaceType.greyHoundRacing.getRaceTypeId():
            return "greyhound"
        default:
            return ""
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
