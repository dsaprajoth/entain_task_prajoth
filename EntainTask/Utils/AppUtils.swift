//
//  AppUtils.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 14/12/2024.
//

import SwiftUI

struct AppUtils {
    /**
     func formatTime(_ seconds: Int) -> String
     - parameter seconds: An integer value representing time in seconds (returned from the Race API)
     - returns: A formatted string representation of the time in days, hours, minutes, and seconds.
     */
    func formatTime(_ seconds: Int) -> String {
        let days = seconds / (24 * 3600)
        let remainingAfterDays = seconds % (24 * 3600)
        let hours = remainingAfterDays / 3600
        let remainingAfterHours = remainingAfterDays % 3600
        let minutes = remainingAfterHours / 60
        let remainingSeconds = remainingAfterHours % 60

        // Construct the components only if they are non-zero
        var components: [String] = []
        if days > 0 { components.append("\(days)d") }
        if hours > 0 { components.append("\(hours)h") }
        if minutes > 0 { components.append("\(minutes)m") }
        components.append("\(remainingSeconds)s")

        // Join components with a space
        return components.joined(separator: " ")
    }
}
