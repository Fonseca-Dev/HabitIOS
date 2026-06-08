//
//  HabitView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack{
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else if case HabitUIState.emptyList = viewModel.uiState {
            } else if case HabitUIState.fullList = viewModel.uiState {
            } else {
            }
        }
    }
}

extension HabitView{
    var progress: some View {
        ProgressView()
    }
}

#Preview("Light") {
    HomeViewRouter.makeHabitView()
}

#Preview("Dark") {
    HomeViewRouter.makeHabitView()
        .preferredColorScheme(.dark)
}
