//
//  Untitled.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//
import Foundation
import Combine

class HabitDetailInteractor{
    
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor {
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError>{
        return remote.save(habitId: habitId, request: request)
    }
}
