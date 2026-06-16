//
//  ChartView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 15/06/26.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        Text("Tela de Gráficos")
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(.red)
    }
}

struct TestView: UIViewRepresentable {
    
    typealias UIViewType = UILabel
    
    func makeUIView(context: Context) -> UILabel {
        let lb = UILabel()
        lb.backgroundColor = UIColor.red
        lb.text = "Ola"
        return lb
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        
    }
    
    
}

#Preview {
    ChartView()
}
