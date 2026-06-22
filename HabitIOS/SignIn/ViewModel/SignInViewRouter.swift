//
//  SignInViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import SwiftUI
import Combine

enum SignInViewRouter {
    
    static func makeHomeView(homeViewModel: HomeViewModel) -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
}
