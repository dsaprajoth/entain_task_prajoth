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
    private var timeRemaining: Int
    private var timer: AnyCancellable?
    var refreshFetch: (() -> Void)?
    init(startingTime: Int, refreshFetch: (() -> Void)?) {
        self.timeRemaining = startingTime
        self.refreshFetch = refreshFetch
        startTimer()
    }
    deinit {
        stopTimer()
    }
    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timeRemaining -= 1
                if let time = self?.timeRemaining, time < -3 {
                    self?.refreshFetch?()
                }
                self?.timeFormatted()
            }
    }
    private func stopTimer() {
        timer?.cancel()
    }
    private func timeFormatted() {
        let days = timeRemaining / (24 * 3600)
        let remainingAfterDays = timeRemaining % (24 * 3600)
        let hours = remainingAfterDays / 3600
        let remainingAfterHours = remainingAfterDays % 3600
        let minutes = remainingAfterHours / 60
        let remainingSeconds = remainingAfterHours % 60
        let daysString = days > 0 ? "\(days)d" : ""
        let hrsString = hours > 0 ? "\(hours)h" : ""
        let minString = minutes > 0 ? "\(minutes)m" : ""
        let secString = "\(remainingSeconds)s"
        timeRemainingString = ("\(daysString) \(hrsString) \(minString) \(secString)")
    }
}
