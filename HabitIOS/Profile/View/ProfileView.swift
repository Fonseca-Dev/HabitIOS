//
//  ProfileView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var fullName: String = ""
    @State var email: String = "kaue@gmail.com"
    @State var cpf: String = "111.222.333-44"
    @State var phone: String = "(11) 9 99999-9999"
    @State var birthDate: String = "11/11/1111"
    @State var selectedGender: Gender? = .male

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    
                    Section {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite o nome", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
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
                            TextField("Digite o seu celular", text: $phone)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Data de nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $birthDate)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
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
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
