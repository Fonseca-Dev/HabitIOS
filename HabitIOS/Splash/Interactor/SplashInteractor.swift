//
//  SplashInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 02/06/26.
//

import Foundation
import Combine

class SplashInteractor{
    
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    func fetchUserAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
}
