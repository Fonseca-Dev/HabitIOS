//
//  ProfileRemoteDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 12/06/26.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    // Padrao singleton
    // Temos 1 unico objeto vivo dentro da aplicacao
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init(){
        
    }
    
    func fecthUser() -> Future<ProfileResponse, AppError> {
        return Future<ProfileResponse, AppError> {promise in
            WebService.call(path: .fetchUser, method: .get){ result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    //completion(true, nil)
                    guard let response = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
