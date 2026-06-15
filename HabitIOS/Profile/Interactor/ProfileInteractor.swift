//
//  ProfileInteractor.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 12/06/26.
//
import Foundation
import Combine

class ProfileInteractor{
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    func fecthUser() -> Future<ProfileResponse, AppError>{
        return remote.fecthUser()
    }
}
