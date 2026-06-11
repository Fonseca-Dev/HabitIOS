//
//  ProfileViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject{
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdateValidation = BirthdateValidation()
    
}

extension ProfileViewModel {
    func genderSelectorView(selectedGender: Binding<Gender?>, title: String, genders: [Gender]) -> some View {
        return ProfileViewRouter.makeGenderSelectorView(selectedGender: selectedGender, title: title, genders: genders)
    }
}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}


class BirthdateValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}

