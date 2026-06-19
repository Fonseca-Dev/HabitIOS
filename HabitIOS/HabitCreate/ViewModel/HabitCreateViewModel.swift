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
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    
    // Declaracao de cancelables e publisher, pois a tela de Habit vai estar obersevando a tela de HabitDetail
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>!
    
    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
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
        
        cancellable = interactor.save(
            request: HabitCreateRequest(
                imageDate: imageData,
                name: name,
                label: label
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let appError):
                self.uiState = .error(appError.message)
            case .finished:
                break
            }
        }, receiveValue: { habit in
            self.uiState = .success
            self.habitPublisher.send(true)
        })
    }
}
