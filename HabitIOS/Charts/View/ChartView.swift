//
//  ChartView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 15/06/26.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        ZStack {
            if case ChartUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                VStack{
                    if case ChartUIState.emptyChart = viewModel.uiState{
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum hábito encontrado :(")
                    } else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: 350)
                    }
                }
                .alert(
                    "Habit",
                    isPresented: Binding(
                        get: {
                            if case .error = viewModel.uiState { return true }
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
                    if case .error(let msg) = viewModel.uiState {
                        Text(msg)
                    }
                }
            }
        }.onAppear(perform: viewModel.onAppear)
        
    }
}

//struct TestView: UIViewRepresentable {
//    
//    typealias UIViewType = UILabel
//    
//    func makeUIView(context: Context) -> UILabel {
//        let lb = UILabel()
//        lb.backgroundColor = UIColor.red
//        lb.text = "Ola"
//        return lb
//    }
//    
//    func updateUIView(_ uiView: UILabel, context: Context) {
//        
//    }
//    
//}

#Preview {
    ChartView(viewModel: ChartViewModel(habitId: 1, interactor: ChartInteractor()))
}
