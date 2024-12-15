//
//  RaceListItemViewModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import SwiftUI
import Combine

class RaceListItemViewModel: ObservableObject {
    @Published var timeRemainingString: String = ""
    @Published var isTimerFinished: Bool = false

    var race: RaceSummary
    var advertisedDate: Date
    private var timer: AnyCancellable?

    init(race: RaceSummary) {
        self.race = race
        // Convert epoch time to Date
        self.advertisedDate = Date(timeIntervalSince1970: TimeInterval(race.advertisedStartValue))
        updateTimeRemaining()
        startTimer()
    }

    deinit {
        stopTimer()
    }

    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimeRemaining()
            }
    }

    func updateTimeRemaining() {
        let now = Date()
        let timeInterval = advertisedDate.timeIntervalSince(now)

        if timeInterval < -60 {
            /// If the time interval is less than -60 seconds,
            /// trigger a new fetch as we should not show races beyond a minute
            /// from the advertised start time
            isTimerFinished = true
        } else {
            // Update the time remaining string by formatting it
            timeRemainingString = AppUtils.formatTime(timeInterval)
        }
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

    private func stopTimer() {
        timer?.cancel()
    }

    // Computed properties for the view to display
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
}
