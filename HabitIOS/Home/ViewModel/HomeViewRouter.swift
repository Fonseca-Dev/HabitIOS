//
//  HomeViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
}
