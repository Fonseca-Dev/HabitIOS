//
//  ProfileViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject{
    
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdateValidation = BirthdateValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor){
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fecthUser() {
        self.uiState = .loading
        
        cancellable = interactor.fecthUser()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch(completion){
                    case .failure(let appError):
                        self.uiState =  .fectchError(appError.message)
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { profileResponse in
                    
                    // Pegar a String -> dd/MM/yyyy -> Date
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyy-MM-dd"
                    
                    let dateFormatted = formatter.date(from: profileResponse.birthdate)
                    
                    // Validar a Data
                    guard let dateFormatted = dateFormatted else {
                        self.uiState = .fectchError("Data inválida \(profileResponse.birthdate)")
                        return
                    }
                    
                    // Date -> yyyy-MM-dd -> String
                    formatter.dateFormat = "dd/MM/yyyy"
                    let birthdate = formatter.string(from: dateFormatted)
                    
                    self.userId = profileResponse.id
                    self.email = profileResponse.email
                    self.document = profileResponse.document
                    self.gender = Gender.allCases[profileResponse.gender]
                    self.fullNameValidation.value = profileResponse.fullname
                    self.phoneValidation.value = profileResponse.phone
                    self.birthdateValidation.value = birthdate
                    
                    self.uiState = .fetchSuccess
                }
            )
    }
    
}

extension ProfileViewModel {
    func genderSelectorView(selectedGender: Binding<Gender?>, title: String, genders: [Gender]) -> some View {
        return ProfileViewRouter.makeGenderSelectorView(selectedGender: selectedGender, title: title, genders: genders)
    }
}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "Teste" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "11912341234" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}


class BirthdateValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "20/09/1990" {
        didSet {
            failure = value.count != 10
        }
    }
}

