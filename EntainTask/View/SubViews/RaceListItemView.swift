//
//  RaceListItemView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import SwiftUI

/// Has its own ViewModel and is responsible for displaying the race list item data
/// and listens to the global timer running every second to update countdown
struct RaceListItemView: View {
    @ObservedObject var viewModel: RaceListItemViewModel

    var body: some View {
        HStack {
            Divider()
                .frame(width: 2)
                .background(.pink)
            VStack(alignment: .leading) {
                HStack {
                    Image(viewModel.race.icon)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.raceTileIcon)
                    Text(viewModel.raceNumber)
                        .font(.appFontSmallBold)
                        .foregroundColor(.themeOrangeLight)
                    Text(viewModel.meetingName)
                        .font(.appFontMediumMedium)
                        .accessibilityIdentifier(AccessibilityIdentifiers.meetingNameLabel)
                }
                Text(viewModel.venue)
                    .font(.caption)
                    .foregroundColor(.secondary)

                // epoch seconds converted to human readable format in a computed property
                Text(viewModel.advertisedStartForDisplay)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier(AccessibilityIdentifiers.countdownLabel)
            }
            Spacer()
            Text(viewModel.timeRemainingString)
                .font(.appFontSmallBold)
                .foregroundColor(viewModel.colorForTimeRemaining)
        }
    }
}
