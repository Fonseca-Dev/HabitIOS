//
//  HabitCardViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 10/06/26.
//

import SwiftUI

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name: String, label: String) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        return HabitDetailView(viewModel: viewModel)
    }
}
