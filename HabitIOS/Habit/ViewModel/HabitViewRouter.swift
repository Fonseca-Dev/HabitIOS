//
//  HabitViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 19/06/26.
//

import SwiftUI
import Combine

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitDetailInteractor())
        // Aqui é onde eu passo o observador da HabitCardViewModel para HabitCreateViewModel
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
