//
//  RaceListView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 14/12/2024.
//

import SwiftUI

struct RaceListView: View {
    @StateObject var viewModel: NextRaceViewModel

    var body: some View {
        List(viewModel.nextRaceList.indices, id: \.self) { index in
            let race: RaceSummary = viewModel.nextRaceList[index]
            HStack {
                Divider()
                    .frame(width: 2)
                    .background(.pink)
                VStack(alignment: .leading) {
                    HStack {
                        Image(race.icon)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.raceTileIcon)
                        Text("R\(race.raceNumber ?? 0)")
                            .font(.appFontSmall)
                            .foregroundColor(.themeOrangeLight)
                        Text(race.meetingName ?? "")
                            .font(.appFontMedium)
                    }
                    Text(race.venueCountry ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(race.advertisedStartForDisplay)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    if let countdownViewmodel = viewModel.countdownViewModels?[index] {
                        CountdownTimerView(viewModel: countdownViewmodel)
                    }
                }
            }
            .accessibilityElement(children: .ignore)
            .if(let: race.raceTitleAccessibility) { view, accessibility in
                view.accessibilityLabel(Text(accessibility))
            }
        }
        .listStyle(.inset)
        .listRowSeparator(.hidden)
    }
}
