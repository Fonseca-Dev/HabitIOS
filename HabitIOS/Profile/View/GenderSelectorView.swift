//
//  GenderSelectorView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let title: String
    let genders: [Gender]
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id){ item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {apGesture in
                        if selectedGender == item {
                            selectedGender = nil
                        } else {
                            selectedGender = item
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(nil), title: "Teste", genders: Gender.allCases)
}
