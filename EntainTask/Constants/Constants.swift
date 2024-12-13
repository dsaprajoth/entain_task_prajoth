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

struct CategoryIds {
    static let horseRacing = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    static let harnessRacing = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    static let greyHoundRacing = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
}

struct ColorConstants {
    static let themeLight = Color("ThemeOrangeLight")
    static let chipSelected = Color("chipSelected")
    static let chipUnselected = Color("chipUnselected")
    static let chipIconSelected = Color("chipIconSelected")
    static let chipIconUnselected = Color("chipIconUnselected")
    static let chipBgSelected = Color("chipBgSelected")
    static let chipBgUnselected = Color("chipBgUnselected")
    static let raceTileIcon = Color("raceTileIcon")
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
