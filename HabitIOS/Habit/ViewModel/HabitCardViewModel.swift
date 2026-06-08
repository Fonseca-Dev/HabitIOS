//
//  HabitCardViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//
import SwiftUI

// Identifiable -> para identificar pelo ID
// Equatable    -> para conseguir comparar os componentes
struct HabitCardViewModel: Identifiable, Equatable {
    
    var id: Int = 0
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .gray
    
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
