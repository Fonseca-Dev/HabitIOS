//
//  SignInView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20){
                            Spacer(minLength: 36)
                            VStack(alignment: .center) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                            }
                        }
                        .navigationTitle("Login")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        if case SignInUIState.error(let error) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                                        // Faz algo quando some o alerta
                                    })
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle(Text("Login"), displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "E-mail",
            keyboard: .emailAddress,
            error: "e-mail invalido",
            failure: !viewModel.email.isEmail()
        )
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Senha",
            keyboard: .emailAddress,
            error: "senha deve ter ao menos 8 caracteres",
            failure: viewModel.password.count < 8,
            isSecure: true
        )
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(
            action: {
                viewModel.login()
            },
            text: "Entrar",
            disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
            showProgressBar: self.viewModel.uiState == SignInUIState.loading
        )
    }
}

extension SignInView {
    var registerLink: some View {
        VStack{
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            //            let signInViewModel = SignInViewModel()
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    label: {
                        Text("Realize seu cadastro")
                    }
                )
                //                NavigationLink(
                //                    destination: Text("Tela de Cadastro"),
                //                    tag: 1,
                //                    selection: $action,
                //                    label: {EmptyView()}
                //                )
                //
                //                Button("Realize seu cadastro") {
                //                    self.action = 1
                //                }
            }
        }
    }
}

#Preview("Light") {
    let viewModel = SignInViewModel(interactor: SignInInteractor(), homeViewModel: HomeViewModel())
    SignInView(viewModel: viewModel)
}

#Preview("Dark") {
    let viewModel = SignInViewModel(interactor: SignInInteractor(), homeViewModel: HomeViewModel())
    SignInView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
