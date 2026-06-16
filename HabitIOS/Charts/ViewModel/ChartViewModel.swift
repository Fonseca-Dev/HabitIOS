//
//  ChartViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 16/06/26.
//

import Combine
import Charts

class ChartViewModel: ObservableObject {
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 2.0),
        ChartDataEntry(x: 2, y: 5.0),
        ChartDataEntry(x: 3, y: 6.0),
        ChartDataEntry(x: 4, y: 1.0),
        ChartDataEntry(x: 5, y: 4.0),
        ChartDataEntry(x: 6, y: 4.0),
        ChartDataEntry(x: 7, y: 5.0),
        ChartDataEntry(x: 8, y: 9.0),
        ChartDataEntry(x: 9, y: 8.0),
        ChartDataEntry(x: 10, y: 7.0),
    ]
    
    @Published var dates = [
        "01/01/2026",
        "02/01/2026",
        "03/01/2026",
        "04/01/2026",
        "05/01/2026",
        "06/01/2026",
        "07/01/2026",
        "08/01/2026",
        "09/01/2026",
        "10/01/2026",
    ]
}
