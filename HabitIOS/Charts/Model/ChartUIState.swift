//
//  ChartUIState.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 17/06/26.
//

enum ChartUIState : Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
