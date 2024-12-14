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
                // MARK: - Top Header (Logo and Title)
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

                // MARK: - Filter Header
                ChipFilterView(viewModel: viewModel)

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
                        if viewModel.nextRaceList.count == 0 {
                            // Show error message when no races are available
                            VStack {
                                Text(StringConstants.noRaceText)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        } else {
                            // Show list of races. Extracted to a separate file RaceListView
                            RaceListView(viewModel: viewModel)
                        }
                        // FIXME: - Remove reload button. Used for testing
                        Button {
                            viewModel.fetchData()
                        } label: {
                            Text(StringConstants.reload)
                                .foregroundColor(.white)
                                .padding()
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
