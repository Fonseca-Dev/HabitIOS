//
//  ChartViewModel.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 16/06/26.
//

import Combine
import Charts

class ChartViewModel: ObservableObject {
    
    @Published var uiState = ChartUIState.loading
    
    @Published var entries: [ChartDataEntry] = []
    
    @Published var dates : [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear(){
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                    case .finished:
                        break
                    }
                },
                receiveValue: { res in
                    if res.isEmpty {
                        self.uiState = .emptyChart
                    } else {
                        self.dates = res.map{ $0.createdDate }
                        
                        self.entries = zip(res.startIndex..<res.endIndex, res).map { index, res in
                            ChartDataEntry(x: Double(index), y: Double(res.value))
                        }
                        
                        self.uiState = .fullChart
                    }
                }
            )
    }
    
}
