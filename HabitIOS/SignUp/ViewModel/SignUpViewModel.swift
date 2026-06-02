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
    
    private let interactor: SignUpInteractor
    
    private var cancellableSignUpRequest: AnyCancellable?
    private var cancellableSignInRequest: AnyCancellable?
    
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSignUpRequest?.cancel()
        cancellableSignInRequest?.cancel()
    }
    
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
        cancellableSignUpRequest = interactor.signUp(
            request: SignUpRequest(
                fullname: fullname,
                email: email,
                document: document,
                phone: phone,
                birthdate: birthdate,
                password: password,
                gender: gender.index
            )
        )
        .receive(on: DispatchQueue.main)
        .sink{completion in
            switch(completion){
            case .failure(let appError):
                self.uiState = .error(appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { success in
            // Aqui eu confirmo se success veio como true, pois é retornado um Booleano
            if success {
                self.cancellableSignInRequest = self.interactor.login(request: SignInRequest(email: self.email, password: self.password))
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
                    } receiveValue: { successSignIn in
                        // Aqui acontece o Sucesso
                        print(successSignIn)
                        self.publisher.send(success)
                        self.uiState = .success
                    }
            }
        }
        
    }
}

extension SignUpViewModel{
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
