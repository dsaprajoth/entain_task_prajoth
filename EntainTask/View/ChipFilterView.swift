//
//  SegmentedView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

struct ChipFilterView: View {
    @StateObject var viewModel: NextRaceViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            buttonView(raceType: .horseRacing)
            buttonView(raceType: .harnessRacing)
            buttonView(raceType: .greyHoundRacing)
        }
        .frame(height: 40)
    }
    
    @ViewBuilder
    func buttonView(raceType: RaceType) -> some View {
        Button(action: {
            viewModel.filter(by: raceType)
        }) {
            Image(raceType.getRaceTypeIcon())
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(viewModel.selectedFilters.contains(raceType) 
                                 ? .white
                                 : .black)
        }
        .frame(width: 100, height: 40)
        .background(viewModel.selectedFilters.contains(raceType) 
                    ? ColorConstants.chipSelected
                    : ColorConstants.chipUnselected)
        .cornerRadius(30)
        .contentShape(Rectangle())
        .accessibilityLabel(Text("Filter \(raceType.rawValue)"))
    }
}
