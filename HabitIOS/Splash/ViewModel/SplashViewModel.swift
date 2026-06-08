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
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?

    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchUserAuth()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { userAuth in
                // Se userAuth for nulo vai para tela de Login
                if(userAuth == nil){
                    self.uiState = .goToSignInScreen
                }
                // Senao se userAuth != null && expirou o token
                // refresh token
                else if(Date().timeIntervalSince1970 > userAuth!.expires) {
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(request: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: {completion in
                            switch(completion){
                                // O _ foi usado, pois nao utilizaremos a mensagem de erro no momento
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(
                                idToken: success.accessToken,
                                refreshToken: success.refreshToken,
                                // Aqui eu salvo no banco de Dados a Hora que foi salvo + o tempo de expiracao
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                tokenType: success.tokenType
                            )
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeScreen
                        })
                        
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
