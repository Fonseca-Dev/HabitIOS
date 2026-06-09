//
//  HomeViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel(interactor: HabitInteractor())
        return HabitView(viewModel: viewModel)
    }
}
