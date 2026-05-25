//
//  SignInViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
    
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
    
    func login(email: String, password: String) {
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Aqui é chamado depois de 3 segundos
            self.uiState = .goToHomeScreen
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
