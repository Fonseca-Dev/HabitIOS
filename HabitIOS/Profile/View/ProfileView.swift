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
    
    @State var email: String = "kaue@gmail.com"
    @State var cpf: String = "111.222.333-44"
    @State var selectedGender: Gender? = .male

    var body: some View {
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
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
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
                            viewModel.genderSelectorView(selectedGender: $selectedGender, title: "Selecione seu sexo", genders: Gender.allCases)
                        } label: {
                            HStack {
                                Text("Gênero")
                                
                                Spacer()
                                
                                Text(selectedGender?.rawValue ?? "")
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
    }
}

    

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
