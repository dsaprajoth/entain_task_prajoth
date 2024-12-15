//
//  AppUtils.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 14/12/2024.
//

import SwiftUI

struct AppUtils {
    /**
     func formatTime(_ interval: TimeInterval) -> String
     This function formats the time interval in epoch into a human-readable format for countdown purposes.
     - parameter epochTime: TimeInterval value in epoch format relative to current date time and advertised date time
     - returns: A formatted string representation of the time in days, hours, minutes, and seconds.
     */
    static func formatTime(_ epochTime: TimeInterval) -> String {
        let days = Int(epochTime) / 86400
        let hours = (Int(epochTime) % 86400) / 3600
        let minutes = (Int(epochTime) % 3600) / 60
        let seconds = Int(epochTime) % 60

        // Construct the components only if they are non-zero
        var components: [String] = []
        if days > 0 { components.append("\(days)d") }
        if hours > 0 { components.append("\(hours)h") }
        if minutes > 0 { components.append("\(minutes)m") }
        components.append("\(seconds)s")

        // Join components with a space
        return components.joined(separator: " ")
    }

    /**
     func convertEpochToDate(epochTime: TimeInterval) -> String
     This function formats the time interval in epoch into a human-readable format for display purposes.
     - parameter epochTime: TimeInterval value in epoch format returned by the Race API
     - returns: A formatted string representation of the time in days, hours, minutes, and seconds.
     */
    static func convertEpochToDate(epochTime: TimeInterval) -> String {
        // Create a Date instance
        let date = Date(timeIntervalSince1970: epochTime)

        // Configure the DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium // You can change this to .short, .medium, .long, or .full
        dateFormatter.timeStyle = .short // Similarly, you can adjust the time style
        dateFormatter.locale = Locale.current // Ensures the date is formatted based on the user's locale

        // Convert the Date to a formatted String
        return dateFormatter.string(from: date)
    }

    /**
     func 
     static func fetchRaceMockResponse() -> NextRacesResponse?
     This function fetches mock json for unit testing view models.
     */
    static func fetchRaceMockResponse() -> NextRacesResponse? {
        if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NextRacesResponse.self, from: data)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }

}
