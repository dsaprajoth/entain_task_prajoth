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
        List(viewModel.nextRaceList, id: \.raceID) { race in
            RaceListItemView(race: race)
                .accessibilityElement(children: .ignore)
                .if(let: race.raceTitleAccessibility) { view, accessibility in
                    view.accessibilityLabel(Text(accessibility))
                }
        }
        .listStyle(.inset)
        .listRowSeparator(.hidden)
    }
}
