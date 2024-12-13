//
//  NextRaceModel.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

//   let raceData = try? JSONDecoder().decode(RaceData.self, from: jsonData)
import Foundation

enum RaceType: String {
    case horseRacing = "horseRacing"
    case harnessRacing = "harnessRacing"
    case greyHoundRacing = "greyHoundRacing"
    
}
extension RaceType {
    func getRaceTypeId() -> String {
        switch self {
        case .horseRacing:
            return "4a2788f8-e825-4d36-9894-efd4baf1cfae"
        case .harnessRacing:
            return "161d9be2-e909-4326-8c2c-35ed71fb460b"
        case .greyHoundRacing:
            return "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
        }
    }
    
    func getRaceTypeIcon() -> String {
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

//enum RaceFilter: String, CaseIterable {
//    case all = "All"
//    case horseRacing = "Horse Racing"
//    case harnessRacing = "Harness Racing"
//    case greyHoundRacing = "GreyHound Racing"
//}
//
//extension RaceFilter {
//    func getRaceFilterIcon() -> String {
//        switch self {
//        case .all:
//            return ""
//        case .horseRacing:
//            return "horse"
//        case .harnessRacing:
//            return "harness"
//        case .greyHoundRacing:
//            return "greyhound"
//        }
//    }
//}

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

struct AdvertisedStart: Codable {
    let seconds: Int?
}

extension AdvertisedStart {
    func secondsToMinutesAndSeconds() -> String {
        let duration = Duration.seconds(self.seconds!)
        let format = duration.formatted(
            .time(
                pattern: .hourMinuteSecond(
                    padHourToLength: 2
                )
            )
        )
        return format
        //        let minutes = self.seconds! / 60
        //        let remainingSeconds = self.seconds! % 60
        //        return "\(minutes) min \(remainingSeconds) sec"
    }
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
