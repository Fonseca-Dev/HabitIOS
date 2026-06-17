//
//  ChartInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 17/06/26.
//

import Foundation
import Combine

class ChartInteractor{
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError>{
        return remote.fecthHabitValues(habitId: habitId)
    }
}
