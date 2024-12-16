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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var raceListItemViewModels: [RaceListItemViewModel]? = []
    @Published var races: [RaceListItemViewModel] = []
    var racesViewModels: [RaceListItemViewModel] = []

    private var cancellables = Set<AnyCancellable>()
    private var countdownCancellables = Set<AnyCancellable>()
    private let networkService: NetworkService

    var selectedFilters: [RaceType] = []
    var raceListFromAPI: [RaceSummary] = []

    // Allows dependency injection of any NetworkService conforming type (NetworkManager or MockNetworkManager)
    init(networkService: NetworkService) {
        self.networkService = networkService
        observeGlobalTimer()
    }

    deinit {
        TimerManager.shared.stopTimer()
    }

    /// Observes the global shared timer for countdown updates
    private func observeGlobalTimer() {
        TimerManager.shared.$currentTime
            .sink { [weak self] _ in
                self?.updateRaces()
            }
            .store(in: &cancellables)
    }

    /// Updates each race's time and checks if data needs to be refreshed
    private func updateRaces() {
        var shouldFetch = false

        for race in races {
            race.updateTimeRemaining(currentTime: TimerManager.shared.currentTime)
            if race.isTimerFinished {
                // race.isTimerFinished is true when one of the races go beyond a minute
                shouldFetch = true
            }
        }

        if shouldFetch {
            fetchData()
        }
    }

    func fetchData() {
        countdownCancellables.removeAll()
        guard let url = URL(string: APIConstants.endpoint) else { return }

        errorMessage = nil
        isLoading = true
        networkService.fetch(url: url, responseType: NextRacesResponse.self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("Data fetched successfully. Fallthrough to `receiveValue`")
                case .failure(let error):
                    // Failed to fetch data
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.raceListFromAPI = data.data?.raceSummaries?.values.map { $0 } ?? []
                // Filter out races beyond a minute from the advertised start time
                self?.dropIrrelevantData()
                // Sort the races based on the advertised start time ascending
                self?.sortData()
                // Pick the first 5 races from the list
                self?.raceListFromAPI = Array(self?.raceListFromAPI.prefix(5) ?? [])

                self?.racesViewModels = self?.raceListFromAPI.map { RaceListItemViewModel(race: $0) } ?? []
                self?.races.removeAll()
                self?.filter(by: nil) // Apply existing filters, if any
            })
            .store(in: &cancellables)
    }

    func filter(by raceType: RaceType?) {
        countdownCancellables.removeAll()

        if let raceType {
            if selectedFilters.contains(raceType) {
                selectedFilters.removeAll { $0 == raceType }
            } else {
                selectedFilters.append(raceType)
            }
        }

        var filteredList: [RaceListItemViewModel] = []
        if selectedFilters.isEmpty {
            filteredList.append(contentsOf: racesViewModels)
        } else {
            let raceCategoryIds = selectedFilters.map { $0.categoryId }
            filteredList = racesViewModels.filter { raceCategoryIds.contains($0.race.categoryID ?? "") }
        }
        races = filteredList
        sortData()
    }

}

extension NextRaceViewModel {
    func dropIrrelevantData() {
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
