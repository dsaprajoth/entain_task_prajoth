//
//  RaceListItemViewModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import SwiftUI
import Combine

class RaceListItemViewModel: ObservableObject, Identifiable {
    @Published var timeRemainingString: String = ""
    @Published var isTimerFinished: Bool = false

    var race: RaceSummary
    var advertisedDate: Date

    init(race: RaceSummary) {
        self.race = race
        // Convert epoch time to Date
        self.advertisedDate = Date(timeIntervalSince1970: TimeInterval(race.advertisedStartValue))
        updateTimeRemaining(currentTime: Date()) // Initial calculation
    }

    /// Updates the time remaining based on the global timer
    func updateTimeRemaining(currentTime: Date) {
        debugPrint(currentTime)
        let timeInterval = advertisedDate.timeIntervalSince(currentTime)

        if timeInterval < -60 {
            // Need to trigger a refresh as the race's start time has passed over a minute
            isTimerFinished = true
        } else {
            timeRemainingString = AppUtils.formatTime(timeInterval)
        }
    }
}

// Extension that holds computed properties for the view to display
extension RaceListItemViewModel {
    var meetingName: String {
        race.meetingName ?? ""
    }

    var raceNumber: String {
        guard let raceNumber = race.raceNumber else {
            return ""
        }
        return "R\(raceNumber)"
    }

    var venue: String {
        race.venueCountry ?? ""
    }

    var advertisedStartForDisplay: String {
        race.advertisedStartForDisplay
    }

    /// Returns the color for the time remaining label
    /// based on the time interval range
    var colorForTimeRemaining: Color {
        let now = Date()
        let timeInterval = advertisedDate.timeIntervalSince(now)

        switch timeInterval {
        case ...0:
            return .red
        case ...60:
            return .orange
        default:
            return .green
        }
    }
}
