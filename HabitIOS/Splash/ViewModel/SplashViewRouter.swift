//
//  SwiftUIView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSigInView() -> some View {
        let homeViewModel = HomeViewModel()
        
        let viewModel = SignInViewModel(interactor: SignInInteractor(), homeViewModel: homeViewModel)
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
