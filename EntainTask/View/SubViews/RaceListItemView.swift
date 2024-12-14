//
//  RaceListItemView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 15/12/2024.
//

import SwiftUI

struct RaceListItemView: View {
    @StateObject var viewModel: RaceListItemViewModel

    // Passing race object to RaceListItemViewModel
    init(race: RaceSummary) {
        _viewModel = StateObject(wrappedValue: RaceListItemViewModel(race: race))
    }

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
                    Text("R\(viewModel.race.raceNumber ?? 0)")
                        .font(.appFontSmallBold)
                        .foregroundColor(.themeOrangeLight)
                    Text(viewModel.race.meetingName ?? "")
                        .font(.appFontMediumMedium)
                }
                Text(viewModel.race.venueCountry ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(viewModel.race.advertisedStartForDisplay)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(viewModel.timeRemainingString)
                .font(.appFontSmallBold)
                .foregroundColor(viewModel.colorForTimeRemaining)
        }
    }
}
