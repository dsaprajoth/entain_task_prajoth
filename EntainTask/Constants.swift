//
//  Constants.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import Foundation
import SwiftUI

struct APIConstants {
    static let endpoint = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=5"
}

struct ColorConstants {
    static let themeLight = Color("ThemeOrangeLight")
    static let chipSelected = Color("chipSelected")
    static let chipUnselected = Color("chipUnselected")
}

struct AssetConstants {
    static let horseRacing = "horse"
    static let harnessRacing = "harness"
    static let greyHoundRacing = "greyhound"
    static let logo = "logo"
}

struct StringConstants {
    static let horseRacing = "Horse Racing"
    static let harnessRacing = "Harness Racing"
    static let greyHoundRacing = "Greyhound Racing"
    static let noRaceText = "No race to display!"
    static let loading = "Loading..."
    static let title = "Next to Go Racing"
}

struct AccessibilityConstants {
    static let logo = "Entain Logo"
    static let harnessRacing = "Harness Racing"
    static let greyHoundRacing = "Greyhound Racing"
    static let noRaceText = "No race to display!"
    static let loading = "Loading..."
    static let title = "Next to Go Racing"
}

extension Font {
    static let titleFont = Font.custom("Avenir", fixedSize: 18)
    static let appFontSmall = Font.custom("Avenir", size: 18)
    static let appFontMedium = Font.custom("Avenir", size: 20)
    static let appFontLarge = Font.custom("Avenir", size: 24)
}
