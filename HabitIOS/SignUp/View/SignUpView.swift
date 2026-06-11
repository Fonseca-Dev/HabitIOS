//
//  SignUpView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
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
        EditTextView(
            text: $viewModel.fullname,
            placeholder: "Entre com seu nome completo *",
            keyboard: .alphabet,
            error: "Nome deve ter mais de tres caracteres",
            failure: viewModel.fullname.count < 3,
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "Entre com seu e-mail *",
            keyboard: .emailAddress,
            error: "e-mail invalido",
            failure: !viewModel.email.isEmail()
        )
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Entre com sua senha *",
            keyboard: .emailAddress,
            error: "senha deve ter ao menos 8 caracteres",
            failure: viewModel.password.count < 8,
            isSecure: true
        )
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(
            text: $viewModel.document,
            placeholder: "Entre com seu CPF *",
            keyboard: .numberPad,
            error: "CPF invalido",
            failure: viewModel.document.count < 11,
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        let fieldOnlyNumbers = viewModel.phone.filter{$0.isNumber}
        return EditTextView(
            text: $viewModel.phone,
            placeholder: "Entre com seu celular *",
            keyboard: .numberPad,
            error: "Entre com o DDD + 8 ou 9 digitos",
            failure: fieldOnlyNumbers.count < 10 || fieldOnlyNumbers.count >= 12
        )
        .onChange(of: viewModel.phone) { newValue in
            viewModel.phone = Validation.mask(
                pattern: "(##)#.####-####",
                value: newValue
            )
        }
    }
}

extension SignUpView {
    var birthdateField: some View {
        EditTextView(
            text: $viewModel.birthdate,
            placeholder: "Entre com sua data de nascimento *",
            keyboard: .numberPad,
            error: "Data deve ser dd/MM/yyyy",
            failure: viewModel.birthdate.count != 10,
        )
        .onChange(of: viewModel.birthdate) { newValue in
            viewModel.birthdate = Validation.mask(
                pattern: "##/##/####",
                value: newValue
            )
        }
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender){
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
        let fieldOnlyNumbers = viewModel.phone.filter{$0.isNumber}
        return LoadingButtonView(
            action: {
                viewModel.signUp()
            },
            text: "Realize o seu Cadastro",
            disabled:
                !viewModel.email.isEmail() ||
            viewModel.password.count < 8 ||
            viewModel.fullname.count < 3 ||
            viewModel.document.count < 11 ||
            fieldOnlyNumbers.count < 10 || fieldOnlyNumbers.count >= 12 ||
            viewModel.birthdate.count != 10,
            showProgressBar: self.viewModel.uiState == SignUpUIState.loading
        )
    }
}

#Preview("Light") {
    VStack{
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack{
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .preferredColorScheme(.dark)
}
