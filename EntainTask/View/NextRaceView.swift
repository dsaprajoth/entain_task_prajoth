//
//  ContentView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NextRaceViewModel(dataFetcher: RaceDataFetcher())
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView(StringConstants.loading)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else {
                    VStack {
                        Image(AssetConstants.logo)
                            .accessibilityRemoveTraits(.isImage)
                            .accessibilityLabel(Text(AccessibilityConstants.logo))
                        Text(StringConstants.title)
                            .font(.appFontLarge)
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    }
                    .frame(height: 80)
                    ChipFilterView(viewModel: viewModel)
                    VStack {
                        if viewModel.nextRaceList.count == 0 {
                            VStack {
                                Text(StringConstants.noRaceText)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        } else {
                            List(viewModel.nextRaceList, id: \.raceID) { race in
                                HStack {
                                    Divider()
                                        .frame(width: 2)
                                        .background(.pink)
                                    VStack(alignment: .leading) {
                                        Image(viewModel.getRaceIcon(from: race.categoryID ?? ""))
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
                                    CountdownTimerView(startingTime: race.advertisedStartValue, timerFinished: {
                                        viewModel.fetchData(mock: false)
                                    })
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(Text(race.raceTitleAccessibility))
                            }
                            .background(.green)
                            .listStyle(.inset)
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.themeLight)
        }
        .task {
            viewModel.fetchData(mock: false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
