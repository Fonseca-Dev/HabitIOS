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
    
    private var cancellable: AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchUserAuth()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { userAuth in
                // Se userAuth for nulo vai para tela de Login
                if(userAuth == nil){
                    self.uiState = .goToSignInScreen
                }
                // Senao se userAuth != null && expirou o token
                // refresh token
                else if(Date().timeIntervalSince1970 > userAuth!.expires) {
                    
                }
                // Senao vai para tela principal
                else {
                    self.uiState = .goToHomeScreen
                }
            })
        
        
        
    }

}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSigInView()
    }
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
}
