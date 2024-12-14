//
//  ChipFilterViewModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 14/12/2024.
//

import SwiftUI
import Combine

class CountdownViewModel: ObservableObject {
    @Published var timeRemainingString: String = ""
    @Published var isTimerFinished: Bool = false

    private var advertisedDate: Date
    private var timer: AnyCancellable?

    init(epochTime: TimeInterval) {
        self.advertisedDate = Date(timeIntervalSince1970: epochTime)
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
