//
//  HabitView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack{
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else {
                NavigationStack{
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12){
                            if !viewModel.isCharts {
                                topContainer
                                
                                addButton
                            }
                            
                            if case HabitUIState.emptyList = viewModel.uiState {
                                
                                VStack{
                                    Spacer(minLength: 60)
                                    
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                                
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                
                                LazyVStack {
                                    ForEach(rows) { row in
                                        HabitCardView(viewModel: row, isChart: viewModel.isCharts)
                                    }
                                }.padding(.horizontal, 14)
                                
                            }
                        }
                    }
                    .navigationTitle("Hábitos")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .alert(
                    "Ops!",
                    isPresented: Binding(
                        get: {
                            if case .failure = viewModel.uiState { return true }
                            return false
                        },
                        set: { _ in }
                    )
                ) {
                    Button("Tentar novamente") {
                        viewModel.onAppear()
                    }
                    Button("Cancelar", role: .cancel) { }
                } message: {
                    if case .failure(let msg) = viewModel.uiState {
                        Text(msg)
                    }
                }
            }
        }
        .onAppear{
            viewModel.onAppear()
        }
    }
}

extension HabitView{
    var progress: some View {
        ProgressView()
    }
}

extension HabitView{
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(.orange)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.subheadline))
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView{
    var addButton: some View {
        NavigationLink(
            destination: Text("Tela de adicionar")
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity)
        ){
            Label("Criar Hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

#Preview("Light") {
    HomeViewRouter.makeHabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
}

#Preview("Dark") {
    HomeViewRouter.makeHabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
        .preferredColorScheme(.dark)
}
