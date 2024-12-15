//
//  NextRaceVM.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Combine
import Foundation

@MainActor
class NextRaceViewModel: ObservableObject {
    @Published var nextRaceList: [RaceSummary] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var raceListItemViewModels: [RaceListItemViewModel]? = []

    private var cancellables = Set<AnyCancellable>()
    private var countdownCancellables = Set<AnyCancellable>()
    private let networkService: NetworkService

    var selectedFilters: [RaceType] = []
    var raceListFromAPI: [RaceSummary] = []

    // Allows dependency injection of any NetworkService conforming type (NetworkService or MockNetworkService)
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchData() {
        var mock = false
        if networkService is MockNetworkManager {
            mock = true
        }

        guard let url = URL(string: APIConstants.endpoint) else { return }

        isLoading = true
        networkService.fetch(url: url, responseType: NextRacesResponse.self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    debugPrint("Data fetched successfully")
                    break
                case .failure(let error):
                    debugPrint("Failed to fetch data: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.raceListFromAPI = data.data?.raceSummaries?.values.map { $0 } ?? []
                // Filter out races beyond a minute from the advertised start time
                if !mock {
                    self?.filterData()
                }
                // Sort the races based on the advertised start time
                self?.sortData()
                // Pick the first 5 races from the list
                self?.raceListFromAPI = Array(self?.raceListFromAPI.prefix(5) ?? [])
                // Create countdown view models for every race (These are the child view models)
                self?.raceListItemViewModels = self?.raceListFromAPI.map {
                    RaceListItemViewModel(race: $0)
                }
                // Observe each child view model
                guard let raceListItemViewModels = self?.raceListItemViewModels else { return }
                for raceListItemViewModel in raceListItemViewModels {
                    self?.observeChildViewModel(raceListItemViewModel)
                }
                // Clear the main list nextRaceList, copy the filtered and sorted list to the main list
                self?.nextRaceList.removeAll()
                self?.nextRaceList.append(contentsOf: self?.raceListFromAPI ?? [])
            })
            .store(in: &cancellables)
    }

    func observeChildViewModel(_ childViewModel: RaceListItemViewModel) {
        childViewModel.$isTimerFinished
            .sink { [weak self] isFinished in
                if isFinished {
                    debugPrint("Timer has reached zero!")
                    self?.fetchData()
                }
            }
            .store(in: &countdownCancellables)
    }

    func filter(by raceType: RaceType) {
        countdownCancellables.removeAll()
        if selectedFilters.contains(raceType) {
            selectedFilters.removeAll { $0 == raceType }
        } else {
            selectedFilters.append(raceType)
        }

        var filteredList: [RaceSummary] = []
        if selectedFilters.isEmpty {
            filteredList.append(contentsOf: raceListFromAPI)
        } else {
            let raceCategoryIds = selectedFilters.map { $0.categoryId }
            filteredList = raceListFromAPI.filter { raceCategoryIds.contains($0.categoryID ?? "") }
        }
        // Create countdown view models for every race (These are the child view models)
//        self.countdownViewModels = filteredList.map {
//            CountdownViewModel(epochTime: TimeInterval($0.advertisedStartValue))
//        }
//        // Observe each child view model
//        guard let countdownViewModels = self.countdownViewModels else { return }
//        for countdownViewModel in countdownViewModels {
//            self.observeChildViewModel(countdownViewModel)
//        }

        self.nextRaceList = filteredList
        sortData()
    }

    func filterData() {
        // Ensure there are no races beyond a minute from the advertised start time
        let now = Date().timeIntervalSince1970
        let oneMinuteFromNow = now - 60
        self.raceListFromAPI = self.raceListFromAPI.filter { TimeInterval($0.advertisedStartValue) > oneMinuteFromNow }
    }

    func sortData() {
        // Sort the race list based on the advertised start time ascending
        self.raceListFromAPI.sort { $0.advertisedStart?.seconds ?? 0 < $1.advertisedStart?.seconds ?? 0 }
    }
    
}
