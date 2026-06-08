//
//  HomeViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    
}

extension HomeViewModel{
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
