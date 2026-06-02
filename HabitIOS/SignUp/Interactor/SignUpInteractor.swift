//
//  SignUpInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//
import Foundation
import Combine

class SignUpInteractor{
    private let signUpRemote: SignUpRemoteDataSource = .shared
    private let signInRemote: SignInRemoteDataSource = .shared
    // private let local: LocalDatSource
}

extension SignUpInteractor {
    func signUp(request: SignUpRequest) -> Future<Bool, AppError>{
        return signUpRemote.signUp(request: request)
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError>{
        return signInRemote.login(request: request)
    }
}
