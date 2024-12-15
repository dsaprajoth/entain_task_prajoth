//
//  MockRaceModel.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

/// Mock model that is currently used in Network Layer tests
/// as it does not depend on real life race data
struct MockRaceModel: Decodable {
    let raceNum: Int
    let meetingName: String
    let advertisedStart: String?
    let venue: String?
}
