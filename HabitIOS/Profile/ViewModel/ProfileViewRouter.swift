//
//  ProfileViewRouter.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//

import SwiftUI

enum ProfileViewRouter {
    static func makeGenderSelectorView(selectedGender: Binding<Gender?>, title: String, genders: [Gender]) -> some View {
        return GenderSelectorView(selectedGender: selectedGender, title: title, genders: genders)
    }
}
