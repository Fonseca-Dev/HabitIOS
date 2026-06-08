//
//  SplashInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 02/06/26.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let local: LocalDataSource = .shared
    private let remote: SplashRemoteDataSource = .shared

}

extension SplashInteractor {
    func fetchUserAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
    
    func insertAuth(userAuth: UserAuth){
        return local.insertUserAuth(userAuth: userAuth)
    }
}
