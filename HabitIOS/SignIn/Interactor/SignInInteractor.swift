//
//  SignInInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//
import Foundation

class SignInInteractor{
    
    private let remote: RemoteDataSource = .shared
    // private let local: LocalDatSource
}

extension SignInInteractor {
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void){
        remote.login(request: request, completion: completion)
    }
}
