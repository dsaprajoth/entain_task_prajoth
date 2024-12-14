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
    private var timeRemaining: Int
    private var timer: AnyCancellable?
    init(initialValue: Int) {
        self.timeRemaining = initialValue
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
                    self?.isTimerFinished = true
                }
                self?.timeFormatted()
            }
    }
    private func stopTimer() {
        timer?.cancel()
    }
    private func timeFormatted() {
        timeRemainingString = AppUtils().formatTime(timeRemaining)
    }
}
