//
//  HabitDetailView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//

import SwiftUI
import Combine

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    // Para ter uma refenrencia da View Atual para fazer um dismiss dela
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(.orange)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack{
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h. \nHábitos se controem todos os dias :)")
            
            LoadingButtonView(
                action: {
                    viewModel.save()
                },
                text: "Salvar",
                disabled: self.viewModel.value.isEmpty,
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
    let viewModel = HabitDetailViewModel(id: 1, name: "Tocar guitarra", label: "Horas", interactor: HabitDetailInteractor())
    HabitDetailView(viewModel: viewModel)
}

#Preview("Dark") {
    let viewModel = HabitDetailViewModel(id: 1, name: "Tocar guitarra", label: "Horas", interactor: HabitDetailInteractor())
    HabitDetailView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
