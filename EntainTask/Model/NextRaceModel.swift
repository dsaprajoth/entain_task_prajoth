//
//  NextRaceModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Foundation

/// Model that helps decode the races response from API
struct NextRacesResponse: Codable, Equatable {
    let status: Int?
    let data: RaceData?
    let message: String?
}

struct RaceData: Codable, Equatable {
    let nextToGoIDs: [String]?
    let raceSummaries: [String: RaceSummary]?
    enum CodingKeys: String, CodingKey {
        case nextToGoIDs = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

struct RaceSummary: Codable, Equatable {
    let raceID: String?
    let raceName: String?
    let raceNumber: Int?
    let meetingID: String?
    let meetingName: String?
    let categoryID: String?
    var advertisedStart: AdvertisedStart?
    let raceForm: RaceForm?
    let venueID: String?
    let venueName: String?
    let venueState: String?
    let venueCountry: String?
    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

extension RaceSummary {
    // util to extract the advertisedStartValue
    var advertisedStartValue: Int {
        self.advertisedStart?.seconds ?? 0
    }

    // Converting epoch seconds to human readable string
    var advertisedStartForDisplay: String {
        AppUtils.convertEpochToDate(epochTime: TimeInterval(self.advertisedStartValue))
    }

    // Custom accessibility label for every race list tile
    var raceTitleAccessibility: String? {
        if let meetingName = self.meetingName, let raceNumber = self.raceNumber {
            let advertisedDate = Date(timeIntervalSince1970: TimeInterval(advertisedStartValue))
            let timeInterval = advertisedDate.timeIntervalSince(Date.now)

            let days = Int(timeInterval) / 86400
            let hours = (Int(timeInterval) % 86400) / 3600
            let minutes = (Int(timeInterval) % 3600) / 60
            let seconds = Int(timeInterval) % 60

            // Construct the components only if they are non-zero
            var daysString = ""
            var hoursString = ""
            var minString = ""
            var secString = ""
            if days > 0 { daysString = "\(days)days" }
            if hours > 0 { hoursString = "\(hours)hours" }
            if minutes > 0 { minString = "\(minutes)minutes" }
            secString = "\(seconds)seconds"

            let meetingStr = "Meeting \(meetingName)"
            let raceStr = "Race \(raceNumber)"
            let timeStr = "Starting in \(daysString) \(hoursString) \(minString) \(secString)"
            return "\(meetingStr) \(raceStr) \(timeStr)"
        }
        return ""
    }

    var icon: String {
        switch self.categoryID {
        case RaceType.horseRacing.categoryId:
            return AssetConstants.horseRacingIcon
        case RaceType.harnessRacing.categoryId:
            return AssetConstants.harnessRacingIcon
        case RaceType.greyHoundRacing.categoryId:
            return AssetConstants.greyHoundRacingIcon
        default: return ""
        }
    }
}

struct AdvertisedStart: Codable, Equatable {
    var seconds: Int?
}

struct RaceForm: Codable, Equatable {
    let distance: Int?
    let distanceType: DistanceType?
    let distanceTypeID: String?
    let trackCondition: TrackCondition?
    let trackConditionID: String?
    let weather: Weather?
    let weatherID: String?
    let raceComment: String?
    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
    }
}

struct DistanceType: Codable, Equatable {
    let id: String?
    let name: String?
    let shortName: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}

struct TrackCondition: Codable, Equatable {
    let id: String?
    let name: String?
    let shortName: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}

struct Weather: Codable, Equatable {
    let id: String?
    let name: String?
    let shortName: String?
    let iconURI: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}
