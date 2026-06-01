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
    
    // Quando abre a SignInView ja deixa o observavel preparado
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUIState = .none
    
    // O SignInViewModel começa a escutar esse publisher
    // sink significa: "quando chegar um valor nesse publisher, execute esse bloco".
    // Então sempre que alguém fizer: publisher.send(valor) esse código vai rodar.
    init(){
        cancellable = publisher.sink { value  in
            print("Usuario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        //Main thread
        WebService.login(request: SignInRequest(email: email, password: password)
        ){successResponse, errorResponse in
            // Non Main Thread
            if let error = errorResponse {
                DispatchQueue.main.async{
                    // Agora sim na MainThread
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async{
                    self.uiState = .goToHomeScreen
                }
            }
        }
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
