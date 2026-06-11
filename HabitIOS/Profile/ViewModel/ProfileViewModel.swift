//
//  ProfileViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject{
    
}

extension ProfileViewModel {
    func genderSelectorView(selectedGender: Binding<Gender?>, title: String, genders: [Gender]) -> some View {
        return ProfileViewRouter.makeGenderSelectorView(selectedGender: selectedGender, title: title, genders: genders)
    }
}
