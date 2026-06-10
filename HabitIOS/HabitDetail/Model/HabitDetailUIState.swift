//
//  HabitDetailUIState.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//
import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
