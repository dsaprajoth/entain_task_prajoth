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
                           RaceListView(viewModel: viewModel)
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.themeLight)
        }
        .task {
            viewModel.fetchData(mock: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}