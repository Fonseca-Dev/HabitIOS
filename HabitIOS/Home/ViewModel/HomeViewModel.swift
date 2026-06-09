//
//  HomeViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    // Ajustado para nao ficar recriando a viewModel toda vez que clicarmos no item da TabBar
    let viewModel = HabitViewModel(interactor: HabitInteractor())
}

extension HomeViewModel{
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
}
