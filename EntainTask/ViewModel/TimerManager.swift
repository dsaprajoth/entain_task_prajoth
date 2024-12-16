//
//  TimerManager.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 16/12/2024.
//

import Combine
import Foundation

class TimerManager: ObservableObject {
    static let shared = TimerManager() // Singleton instance

    @Published var currentTime: Date = Date()
    private var timer: AnyCancellable?

    private init() {
        startTimer()
    }

    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] time in
                self?.currentTime = time
            }
    }

    func stopTimer() {
        timer?.cancel()
    }
}
