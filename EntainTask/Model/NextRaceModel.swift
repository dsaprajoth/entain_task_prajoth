//
//  NextRaceModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Foundation

enum RaceType: String {
    case horseRacing
    case harnessRacing
    case greyHoundRacing
}
extension RaceType {
    var categoryId: String {
        switch self {
        case .horseRacing:
            return CategoryIds.horseRacing
        case .harnessRacing:
            return CategoryIds.harnessRacing
        case .greyHoundRacing:
            return CategoryIds.greyHoundRacing
        }
    }
    var icon: String {
        switch self {
        case .horseRacing:
            return "horse"
        case .harnessRacing:
            return "harness"
        case .greyHoundRacing:
            return "greyhound"
        }
    }
}

struct NextRacesResponse: Codable {
    let status: Int?
    let data: RaceData?
    let message: String?
}

struct RaceData: Codable {
    let nextToGoIDs: [String]?
    let raceSummaries: [String: RaceSummary]?
    enum CodingKeys: String, CodingKey {
        case nextToGoIDs = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

struct RaceSummary: Codable {
    let raceID: String?
    let raceName: String?
    let raceNumber: Int?
    let meetingID: String?
    let meetingName: String?
    let categoryID: String?
    let advertisedStart: AdvertisedStart?
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
    var advertisedStartValue: Int {
        self.advertisedStart?.seconds ?? 0
    }
    var advertisedStartForDisplay: String {
        AppUtils.convertEpochToDate(epochTime: TimeInterval(self.advertisedStartValue))
    }
    var raceTitleAccessibility: String? {
        if let meetingName = self.meetingName, let raceNumber = self.raceNumber {
            let meetingStr = "Meeting \(meetingName)"
            let raceStr = "Race \(raceNumber)"
            let timeStr = "Starting in \(AppUtils.formatTime(TimeInterval(self.advertisedStartValue)))"
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

struct AdvertisedStart: Codable {
    let seconds: Int?
}

struct RaceForm: Codable {
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

struct DistanceType: Codable {
    let id: String?
    let name: String?
    let shortName: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}

struct TrackCondition: Codable {
    let id: String?
    let name: String?
    let shortName: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}

struct Weather: Codable {
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
