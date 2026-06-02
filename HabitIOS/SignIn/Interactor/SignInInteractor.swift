//
//  SignInInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//
import Foundation
import Combine

class SignInInteractor{
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignInInteractor {
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError>{
        return remote.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
