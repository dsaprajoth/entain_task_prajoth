//
//  CountDownView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

struct CountdownTimerView: View {
    @State private var timeRemaining: Int
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var timerFinished: () -> Void

    init(startingTime: Int, timerFinished: @escaping () -> Void) {
        _timeRemaining = State(initialValue: startingTime)
        self.timerFinished = timerFinished
    }

    var body: some View {
        Text(timeFormatted())
            .font(.appFontSmall)
            .onReceive(timer) { _ in
                timeRemaining -= 1
                if timeRemaining < -9 {
                    timerFinished()
                }
            }
    }

    private func timeFormatted() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        if minutes == 0 {
            return String(format: "%02ds", seconds)
        }
        return String(format: "%02dm %02ds", minutes, seconds)
    }
}
