//
//  EditTextView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autocapitalization)
                    .textFieldStyle(CustomTextFieldStyle())
                    .onChange(of: text) { value in
                        if let mask = mask {
                            // Esse & vem da ling C++ e serve como um ponteiro para passar o mesmo endereco para a funcao mudar e retornala com a alteracao
                            Mask.mask(mask: mask, value: value, text: &text)
                        }
                    }
            }
            if let error = error, failure == true, !text.isEmpty {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
            
    }
}

#Preview("Light") {
    EditTextView(
        text: .constant("sssss"),
        placeholder: "E-mail",
        error: "Error",
        failure: "a@a.com".count < 3
    )
}

#Preview("Dark") {
    EditTextView(
        text: .constant("sss"),
        placeholder: "E-mail",
        error: "Error",
        failure: "a@a.com".count < 3
    )
    .preferredColorScheme(.dark)
}

