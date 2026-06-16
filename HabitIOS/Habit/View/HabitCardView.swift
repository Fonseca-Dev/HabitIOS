//
//  HabitCardView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import SwiftUI
import Combine

struct HabitCardView: View {
        
    let viewModel: HabitCardViewModel
    let isChart: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            NavigationLink {
                if isChart {
                    viewModel.chartView()
                } else {
                    viewModel.habitDetailView()
                }
            } label: {
                
                HStack {
                    Imageview(url: viewModel.icon)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(.orange)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4){
                            
                            Text("Registrado")
                                .foregroundColor(.orange)
                                .bold()
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                // Padding interno dos cards
                .padding()
                .cornerRadius(4)
                
                if !isChart {
                    Rectangle()
                        .frame(width: 8)
                        .foregroundColor(viewModel.state)
                }
                
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.orange, lineWidth: 1.4)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                
            )
            // Paddin externo dos cards
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
            
        }
    }
}

#Preview("Light") {
    NavigationStack {
        List {
            HabitCardView(
                viewModel: HabitCardViewModel(
                    id: 1,
                    icon: "https://cdn.tiagoaguiar.dev/habit_plus/1342/1781191893.073395-1781191893.073126.jpeg",
                    date: "01/01/2021 00:00:00",
                    name: "Tocar guitarra",
                    label: "horas",
                    value: "2",
                    state: .green,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                ),
                isChart: false
            )
            HabitCardView(
                viewModel: HabitCardViewModel(
                    id: 2,
                    icon: "https://placehold.co/600x400/png",
                    date: "01/01/2021 00:00:00",
                    name: "Tocar guitarra",
                    label: "horas",
                    value: "2",
                    state: .green,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                ),
                isChart: false
            )
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity)
        .navigationDestination(for: Int.self) { id in
            Text("destination: \(id)")
        }
    }
}

