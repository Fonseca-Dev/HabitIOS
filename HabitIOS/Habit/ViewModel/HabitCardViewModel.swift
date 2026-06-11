//
//  HabitCardViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//
import SwiftUI
import Combine

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
    
    var habitPublisher: PassthroughSubject<Bool, Never>!
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension HabitCardViewModel {
    func habitDetailView() -> some View {
        // Aqui é onde eu passo o observador da HabitCardViewModel para HabitDetailViewModel
        return HabitCardViewRouter.makeHabitDetailView(id: id, name: name, label: label, habitPublisher: habitPublisher)
    }
}
