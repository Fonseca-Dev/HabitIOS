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
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
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
    ChartView(viewModel: ChartViewModel())
}
