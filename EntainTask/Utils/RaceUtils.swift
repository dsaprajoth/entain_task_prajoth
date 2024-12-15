//
//  RaceType.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 16/12/2024.
//

/// This file contains:
/// - CategoryIds for 3 types of races
/// - RaceType enum that helps the app components
///   identify a race's nature and acts accordingly
/// - Extension on RaceType to provide the categoryId and respective icons
struct CategoryIds {
    static let horseRacing = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    static let harnessRacing = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    static let greyHoundRacing = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
}

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
