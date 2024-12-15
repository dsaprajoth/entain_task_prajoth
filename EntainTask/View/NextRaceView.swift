//
//  ContentView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

struct NextRaceView: View {
    @StateObject private var viewModel = NextRaceViewModel(networkService: NetworkManager())

    var body: some View {
        NavigationStack {
            VStack {
                // Top Header (Logo and Title)
                VStack {
                    Image(AssetConstants.logo)
                        .accessibilityRemoveTraits(.isImage)
                        .accessibilityLabel(Text(AccessibilityConstants.logo))
                    Text(StringConstants.title)
                        .font(.appFontLarge)
                        .foregroundColor(Color.white)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                }
                .frame(height: 80)

                // Chip filters to filter races by categories
                ChipFilterView(viewModel: viewModel)

                // Show loading indicator, error message or list of races
                if viewModel.isLoading {
                    ProgressView(StringConstants.loading)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("\(errorMessage)")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .accessibilityLabel(Text("An error has occurred. \(errorMessage)"))
                        Button {
                            viewModel.fetchData()
                        } label: {
                            Text(StringConstants.reload)
                                .font(.appFontSmall)
                                .foregroundColor(.themeOrangeLight)
                                .padding(10)
                        }
                        .contentShape(Rectangle())
                        .background(.white)
                        .cornerRadius(10)
                        .accessibilityLabel(Text("Retry"))
                    }
                } else {
                    VStack {
                        if viewModel.nextRaceList.count == 0 {
                            // Show a message when no races are available
                            VStack {
                                Text(StringConstants.noRaceText)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        } else {
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
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.themeLight)
        }
        .task {
            viewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NextRaceView()
    }
}
