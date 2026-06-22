//
//  HabitCreateView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 18/06/26.
//

import SwiftUI
import Combine

struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    
    // Para ter uma refenrencia da View Atual para fazer um dismiss dela
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldPresentCamera: Bool = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                
                Button {
                    self.shouldPresentCamera = true
                } label: {
                    VStack{
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                        
                        Text("Clique aqui para enviar")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.bottom, 12)
                // Esse sheet é o modal do iOS
                .sheet(isPresented: $shouldPresentCamera) {
                    ImagePickerView(
                        isPresented: $shouldPresentCamera,
                        image: $viewModel.image,
                        imageData: $viewModel.imageData,
                        sourceType: .camera
                    )
                }

            }
            
            VStack{
                TextField("Escreva aqui o nome do seu hábito", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            VStack{
                TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            
            LoadingButtonView(
                action: {
                    viewModel.save()
                },
                text: "Salvar",
                disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty,
                showProgressBar: self.viewModel.uiState == .loading,
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeInOut(duration: 0.15)){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            } label: {
                Text("Cancelar")
                    .modifier(ButtonStyle())
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .navigationTitle("Registrar hábito")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 8)
        .padding(.top, 32)
        .onAppear{
            // Aqui estamos observando a uiState da HabitDetailViewModel
            // Funciona pq a variavel uiState é um Publisher onde ela tem um observavel
            viewModel.$uiState
                .sink { state in
                    if state == .success {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .store(in: &viewModel.cancellables)
        }
        .alert(
            "Ops!",
            isPresented: Binding(
                get: {
                    if case .error = viewModel.uiState { return true }
                    return false
                },
                set: { _ in }
            )
        ) {
            Button("Tentar novamente") {
                viewModel.save()
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            if case .error(let msg) = viewModel.uiState {
                Text(msg)
            }
        }
        
    }
}


#Preview("Light") {
    let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
    HabitCreateView(viewModel: viewModel)
}

#Preview("Dark") {
    let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
    HabitCreateView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
