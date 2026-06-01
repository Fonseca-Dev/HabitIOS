//
//  SignUpViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import Combine
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthdate: String = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    private let interactor: SignUpINteractor
    
    func signUp() {
        uiState = .loading
        
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthdate)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inváçida \(self.birthdate)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdate = formatter.string(from: dateFormatted)
        
        
        //Main thread
        interactor.postUser(
            request: SignUpRequest(
                fullname: fullname,
                email: email,
                document: document,
                phone: phone,
                birthdate: birthdate,
                password: password,
                gender: gender.index
            )
        ){successResponse, errorResponse in
            // Non Main Thread
            // Se der error na criacao do Usuario
            if let error = errorResponse {
                DispatchQueue.main.async{
                    // Agora sim na MainThread
                    self.uiState = .error(error.detail!)
                }
            }
            
            // Se der sucesso na criacao do usuario
            if let success = successResponse {
                
                
                // Main thread
                // Tentativa de fazer login com as credenciais do usuario criado
//                WebService.login(request: SignInRequest(email: self.email, password: self.password)
//                ){successResponse, errorResponse in
//                    // Non Main Thread
//                    // Se der error no login
//                    if let errorSignIn = errorResponse {
//                        DispatchQueue.main.async{
//                            // Agora sim na MainThread
//                            self.uiState = .error(errorSignIn.detail.message)
//                        }
//                    }
//                    
//                    // Se der sucesso no login
//                    if let successSignIn = successResponse {
//                        DispatchQueue.main.async{
//                            print(successSignIn)
//                            self.publisher.send(success)
//                            self.uiState = .success
//                        }
//                    }
//                }
            }
        }
    }
}

extension SignUpViewModel{
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
