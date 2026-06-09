//
//  HabitInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//

import Foundation
import Combine

class HabitInteractor{
    
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError>{
        return remote.fecthHabits()
    }
}
