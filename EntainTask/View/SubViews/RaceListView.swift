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
                    Image(race.icon)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.raceTileIcon)
                    HStack {
                        Text("\(race.raceNumber ?? 0)")
                            .font(.appFontSmall)
                            .foregroundColor(.secondary)
                        Text(race.meetingName ?? "")
                            .font(.appFontMedium)
                    }
                }
                Spacer()
                CountdownTimerView(
                    viewModel: viewModel.countdownViewModels[index]
                )
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text(race.raceTitleAccessibility))
        }
        .background(.green)
        .listStyle(.inset)
        .listRowSeparator(.hidden)
    }
}
