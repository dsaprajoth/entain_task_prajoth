//
//  SegmentedView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

/// Uses the parent - NextRaceView's view model 
/// to filter the data based on the selected chip
struct ChipFilterView: View {
    @StateObject var viewModel: NextRaceViewModel
    var body: some View {
        HStack(spacing: 20) {
            chipButtonView(raceType: .horseRacing)
                .accessibilityIdentifier("HorseRacingChip")
            chipButtonView(raceType: .harnessRacing)
                .accessibilityIdentifier("HarnessRacingChip")
            chipButtonView(raceType: .greyHoundRacing)
                .accessibilityIdentifier("GreyHoundRacingChip")
        }
        .frame(height: 40)
    }
}

extension ChipFilterView {
    @ViewBuilder
    func chipButtonView(raceType: RaceType) -> some View {
        Button {
            viewModel.filter(by: raceType)
        } label: {
            Image(raceType.icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(viewModel.selectedFilters.contains(raceType)
                                 ? .chipIconSelected
                                 : .chipIconUnselected)
                .padding(.horizontal, 40)
                .padding(.vertical, 8)
        }
        .contentShape(Rectangle())
        .background(viewModel.selectedFilters.contains(raceType)
                    ? ColorConstants.chipBgSelected
                    : ColorConstants.chipBgUnselected)
        .cornerRadius(30)
        .accessibilityLabel(Text("Filter \(raceType.rawValue)"))
    }
}
