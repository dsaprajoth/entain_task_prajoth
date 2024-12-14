//
//  CountDownView.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 13/12/2024.
//

import SwiftUI

struct CountdownTimerView: View {
    @StateObject var viewModel: CountdownViewModel
    var body: some View {
        Text(viewModel.timeRemainingString)
            .font(.appFontSmall)
    }
}
