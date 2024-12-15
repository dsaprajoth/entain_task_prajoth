//
//  RaceListItemTestModels.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

import Foundation
@testable import EntainTask

/// Mock race data for testing RaceListItemViewModel
struct RaceMockData {
    static let mockRace: RaceSummary = .init(raceID: "1",
                                             raceName: "Test Race",
                                             raceNumber: 2,
                                             meetingID: "meeting1",
                                             meetingName: "Test Race Meeting",
                                             categoryID: RaceType.horseRacing.categoryId,
                                             advertisedStart: .init(
                                                seconds: Int(Date().addingTimeInterval(120).timeIntervalSince1970)),
                                             raceForm: nil,
                                             venueID: "venue1",
                                             venueName: "Test Venue",
                                             venueState: "Test State",
                                             venueCountry: "USA")

    static let upcomingRace: RaceSummary = .init(raceID: "1",
                                                 raceName: "Test Race",
                                                 raceNumber: 2,
                                                 meetingID: "meeting1",
                                                 meetingName: "Test Race Meeting",
                                                 categoryID: RaceType.horseRacing.categoryId,
                                                 advertisedStart: .init(
                                                    seconds: Int(Date().addingTimeInterval(120).timeIntervalSince1970)),
                                                 raceForm: nil,
                                                 venueID: "venue1",
                                                 venueName: "Test Venue",
                                                 venueState: "Test State",
                                                 venueCountry: "USA")

    static let nearlyStartedRace: RaceSummary = .init(raceID: "1",
                                                      raceName: "Test Race",
                                                      raceNumber: 2,
                                                      meetingID: "meeting1",
                                                      meetingName: "Test Race Meeting",
                                                      categoryID: RaceType.horseRacing.categoryId,
                                                      advertisedStart: .init(
                                                        seconds: Int(Date().addingTimeInterval(30).timeIntervalSince1970)),
                                                      raceForm: nil,
                                                      venueID: "venue1",
                                                      venueName: "Test Venue",
                                                      venueState: "Test State",
                                                      venueCountry: "USA")

    static let pastRace: RaceSummary = .init(raceID: "1",
                                             raceName: "Test Race",
                                             raceNumber: 2,
                                             meetingID: "meeting1",
                                             meetingName: "Test Race Meeting",
                                             categoryID: RaceType.horseRacing.categoryId,
                                             advertisedStart: .init(
                                                seconds: Int(Date().addingTimeInterval(-10).timeIntervalSince1970)),
                                             raceForm: nil,
                                             venueID: "venue1",
                                             venueName: "Test Venue",
                                             venueState: "Test State",
                                             venueCountry: "USA")

}
