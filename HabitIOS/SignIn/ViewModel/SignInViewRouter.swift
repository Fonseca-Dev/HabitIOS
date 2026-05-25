//
//  SignInViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import SwiftUI

enum SignInViewRouter {
    static func makeHomeView() -> some View {
        return HomeView()
    }
    
    static func makeSignUpView() -> some View {
        return SignUpView()
    }
}
