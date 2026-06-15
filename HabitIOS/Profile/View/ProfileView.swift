//
//  ProfileView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure ||
        viewModel.phoneValidation.failure ||
        viewModel.birthdateValidation.failure
    }

    var body: some View {
        ZStack{
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            }
            
            else {
                NavigationStack {
                    
                    VStack {
                        Form {
                            
                            Section {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("Nome deve conter pelo menos 3 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Celular")
                                    Spacer()
                                    TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidation.failure {
                                    Text("Entre com o DDD + 8 ou 9 digitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data de nascimento")
                                    Spacer()
                                    TextField("Digite a sua data de nascimento", text: $viewModel.birthdateValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdateValidation.failure {
                                    Text("Data deve ser dd/MM/yyyy")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink {
                                    viewModel.genderSelectorView(selectedGender: $viewModel.gender, title: "Selecione seu sexo", genders: Gender.allCases)
                                } label: {
                                    HStack {
                                        Text("Gênero")
                                        
                                        Spacer()
                                        
                                        Text(viewModel.gender?.rawValue ?? "")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                            } header: {
                                Text("DADOS CADASTRAIS")
                            }
                            
                        }
                    }
                    .navigationTitle("Editar Perfil")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if !disableDone {
                                Button(action: {
                                    print("Done")
                                }) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
                .alert(
                    "Ops!",
                    isPresented: Binding(
                        get: {
                            if case .fectchError = viewModel.uiState { return true }
                            return false
                        },
                        set: { _ in }
                    )
                ) {
                    Button("Tentar novamente") {
                        viewModel.fecthUser()
                    }
                    Button("Cancelar", role: .cancel) { }
                } message: {
                    if case .fectchError(let msg) = viewModel.uiState {
                        Text(msg)
                    }
                }
            }
        }.onAppear(perform: viewModel.fecthUser)
    }
}

    

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
