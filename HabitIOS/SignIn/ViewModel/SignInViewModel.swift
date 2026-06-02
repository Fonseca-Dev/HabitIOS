//
//  SignInViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?

    
    // Quando abre a SignInView ja deixa o observavel preparado
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    // O SignInViewModel começa a escutar esse publisher
    // sink significa: "quando chegar um valor nesse publisher, execute esse bloco".
    // Então sempre que alguém fizer: publisher.send(valor) esse código vai rodar.
    init(interactor: SignInInteractor){
        self.interactor = interactor
        cancellable = publisher.sink { value  in
            print("Usuario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        //Main thread
        cancellableRequest = interactor.login(request: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                // Aqui acontece o Error ou Finished
                switch(completion){
                case .failure(let appError):
                    self.uiState =  .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                // Aqui acontece o Sucesso
                print(success)
                let auth = UserAuth(
                    idToken: success.accessToken,
                    refreshToken: success.refreshToken,
                    // Aqui eu salvo no banco de Dados a Hora que foi salvo + o tempo de expiracao
                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                    tokenType: success.tokenType
                )
                self.interactor.insertAuth(userAuth: auth)
                self.uiState = .goToHomeScreen
            }
        
        
//        {successResponse, errorResponse in
//            // Non Main Thread
//            if let error = errorResponse {
//                DispatchQueue.main.async{
//                    // Agora sim na MainThread
//                    self.uiState = .error(error.detail.message)
//                }
//            }
//            
//            if let success = successResponse {
//                DispatchQueue.main.async{
//                    print(success)
//                    self.uiState = .goToHomeScreen
//                }
//            }
//        }
    }
    
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    // O publisher é enviado para a tela de cadastro
    // SignInViewModel está escutando
    // SignUpViewModel vai enviar eventos
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
