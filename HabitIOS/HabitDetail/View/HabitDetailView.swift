//
//  HabitDetailView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//

import SwiftUI

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
        .padding(.horizontal, 8)
        .padding(.top, 32)
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

