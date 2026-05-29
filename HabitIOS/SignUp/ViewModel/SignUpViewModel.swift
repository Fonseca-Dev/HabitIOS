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
        
        
        
        WebService.postUser(
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
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.uiState = .success
        //            self.publisher.send(true)
        //        }
    }
    
}

extension SignUpViewModel{
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
