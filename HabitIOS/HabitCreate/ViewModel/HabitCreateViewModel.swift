//
//  HabitDetailViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var name = ""
    @Published var label = ""
    
    private var cancellable: AnyCancellable?
    
    // Declaracao de cancelables e publisher, pois a tela de Habit vai estar obersevando a tela de HabitDetail
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>!
    
    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save(){
        self.uiState = .loading
    }
}
