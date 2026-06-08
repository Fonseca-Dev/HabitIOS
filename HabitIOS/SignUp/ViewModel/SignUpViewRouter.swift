//
//  SignUpRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
