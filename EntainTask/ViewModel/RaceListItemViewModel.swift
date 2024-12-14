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
    private var timer: AnyCancellable?
    private var advertisedDate: Date

    init(race: RaceSummary) {
        self.race = race
        self.advertisedDate = Date(timeIntervalSince1970: TimeInterval(race.advertisedStartValue))
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

    private func updateTimeRemaining() {
        let now = Date()
        let timeInterval = advertisedDate.timeIntervalSince(now)

        if timeInterval <= -60 {
            isTimerFinished = true
        } else {
            timeRemainingString = AppUtils.formatTime(timeInterval)
        }
    }

    var colorForTimeRemaining: Color {
        let now = Date()
        let timeInterval = advertisedDate.timeIntervalSince(now)

        if timeInterval <= 0 {
            return Color.red
        } else if timeInterval <= 60 {
            return Color.orange
        } else {
            return Color.green
        }
    }

    private func stopTimer() {
        timer?.cancel()
    }
}
