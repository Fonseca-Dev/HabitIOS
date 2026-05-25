//
//  SignUpView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel

    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var document: String = ""
    @State private var phone: String = ""
    @State private var birthdate: String = ""
    @State private var gender = Gender.male
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullnameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdateField
                        genderField
                        saveButton
                    }
                    
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            if case SignUpUIState.error(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                            // Faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullnameField: some View {
        TextField("", text: $fullname)
            .border(Color.black)
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("", text: $email)
            .border(Color.black)
    }
}

extension SignUpView {
    var passwordField: some View {
        SecureField("", text: $password)
            .border(Color.black)
    }
}

extension SignUpView {
    var documentField: some View {
        TextField("", text: $document)
            .border(Color.black)
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("", text: $phone)
            .border(Color.black)
    }
}

extension SignUpView {
    var birthdateField: some View {
        TextField("", text: $birthdate)
            .border(Color.black)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender){
            ForEach(Gender.allCases, id: \.self){ value in
                Text(value.rawValue)
                    .tag(value)
            }
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
    }
}

extension SignUpView {
    var saveButton: some View {
        Button("Cadastrar") {
            viewModel.signUp()
        }
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
