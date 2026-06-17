//
//  HabitCardViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 10/06/26.
//

import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name: String, label: String, habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        // Aqui é onde eu passo o observador da HabitCardViewModel para HabitDetailViewModel
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
    
    static func makeChartView(id: Int) -> some View {
        let viewModel = ChartViewModel(habitId: id, interactor: ChartInteractor())
        return ChartView(viewModel: viewModel)
    }
}
