//
//  ProfileEditTextView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/06/26.
//

import SwiftUI

import SwiftUI

struct ProfileEditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocapitalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        // Esse & vem da ling C++ e serve como um ponteiro para passar o mesmo endereco para a funcao mudar e retornala com a alteracao
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                }
        }
        
    }
}

#Preview("Light") {
    ProfileEditTextView(
        text: .constant("sssss"),
        placeholder: "E-mail",
    )
}

#Preview("Dark") {
    ProfileEditTextView(
        text: .constant("sss"),
        placeholder: "E-mail",
    )
    .preferredColorScheme(.dark)
}


