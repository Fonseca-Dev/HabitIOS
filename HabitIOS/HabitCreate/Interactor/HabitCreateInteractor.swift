//
//  HabitCreateInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 19/06/26.
//
import Foundation
import Combine

class HabitCreateInteractor{
    
    private let remote: HabitCreateRemoteDataSource = .shared
}

extension HabitCreateInteractor {
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError>{
        return remote.save(request: request)
    }

}
