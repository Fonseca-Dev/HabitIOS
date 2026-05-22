//
//  SplashViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import Foundation
import Combine
import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUiState = .loading
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Aqui é chamado depois de 3 segundos
            self.uiState = .goToSignInScreen
        }
    }

}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSigInView()
    }
}
