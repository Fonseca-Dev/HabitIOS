//
//  HabitViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import Combine

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
}
