//
//  BoxChartView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 16/06/26.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]

    func makeUIView(context: Context) -> Charts.LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription?.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.granularityEnabled = true
        uiView.xAxis.enabled = true
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = true
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(yAxisDuration: 1.0)

        uiView.data = addData()
        
        return uiView
    }
    
    private func addData() -> LineChartData {
        
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {return LineChartData(dataSet: nil)}
        
        let dataSet = LineChartDataSet(entries: entries, label: "")

        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.drawFilledEnabled = true
        dataSet.valueColors = [.red]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.fill = Fill(linearGradient: gradient, angle: 90.0)
        
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: Charts.LineChartView, context: Context) {
        
    }
    
}

class DateAxisValueFormatter: IAxisValueFormatter {
    
    let dates: [String]
    
    init(dates: [String]){
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let position = Int(value)
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        
        if position >= 0 && position < dates.count {
            let date = df.date(from: dates[position])
            
            guard let date = date else {return ""}
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM"
            let createdAt = df.string(from: date)
            
            return createdAt
        } else {
            return ""
        }
    }
    
    
}

#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 0, y: 2.0),
        ChartDataEntry(x: 1, y: 5.0),
        ChartDataEntry(x: 2, y: 6.0),
        ChartDataEntry(x: 3, y: 1.0),
        ChartDataEntry(x: 4, y: 4.0),
        ChartDataEntry(x: 5, y: 4.0),
        ChartDataEntry(x: 6, y: 5.0),
        ChartDataEntry(x: 7, y: 9.0),
        ChartDataEntry(x: 8, y: 8.0),
        ChartDataEntry(x: 9, y: 7.0),
    ]), dates: .constant([
        "2026-01-01",
        "2026-01-02",
        "2026-01-03",
        "2026-01-04",
        "2026-01-05",
        "2026-01-06",
        "2026-01-07",
        "2026-01-08",
        "2026-01-09",
        "2026-01-10",
    ]))
        .frame(maxWidth: .infinity, maxHeight: 350)
}
