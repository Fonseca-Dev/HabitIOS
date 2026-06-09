//
//  HabitViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import Combine
import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    private let interactor: HabitInteractor
    private var cancellable: AnyCancellable?
    
    
    init(interactor: HabitInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func onAppear() {
        self.uiState = .loading
        
        cancellable = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch(completion){
                    case .failure(let appError):
                        self.uiState =  .failure(appError.message)
                        break
                    case .finished:
                        break
                    }
                    
                }, receiveValue: { habitResponse in
                    if habitResponse.isEmpty {
                        self.uiState = .emptyList
                        self.title = ""
                        self.headline = "Fique ligado!"
                        self.desc = "Você ainda não possui hábitos"
                    } else {
                        self.uiState = .fullList(
                            habitResponse.map{
                                
                                let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                                
                                var state = Color.green
                                self.title = "Muito bom!"
                                self.headline = "Seus hábitos estão em dia"
                                self.desc = ""
                                
                                let dateToCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                                
                                if  dateToCompare < Date() {
                                    state = Color.red
                                    self.title = "Atenção"
                                    self.headline = "Fique ligado!"
                                    self.desc = "Você está atrasado nos hábitos"
                                }
                                
                                return HabitCardViewModel(
                                    id: $0.id,
                                    icon: $0.iconUrl ?? "",
                                    date: lastDate,
                                    name: $0.name,
                                    label: $0.label,
                                    value: "\($0.value ?? 0)",
                                    state: state
                                )
                                
                            }
                        )
                    }
                }
            )
    }
}
