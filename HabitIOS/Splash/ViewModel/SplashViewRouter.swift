//
//  SwiftUIView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSigInView() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
}
