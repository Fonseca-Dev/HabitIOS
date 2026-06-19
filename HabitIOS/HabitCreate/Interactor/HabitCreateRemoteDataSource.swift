//
//  HabitCreateRemoteDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 19/06/26.
//

import Foundation
import Combine

class HabitCreateRemoteDataSource {
    
    // Padrao singleton
    // Temos 1 unico objeto vivo dentro da aplicacao
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init(){
        
    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future<Void, AppError> {promise in
            WebService.call(
                path: .habits,
                params: [
                    URLQueryItem(name: "name", value: request.name),
                    URLQueryItem(name: "label", value: request.label)
                ]){ result in
                    switch result {
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .unauthorized {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                                //completion(nil, response)
                                promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                            }
                            if error == .internalServerError {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(ErrorResponse.self, from: data)
                                promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                            }
                        }
                        break
                    case .success(_):
                        promise(.success( () ))
                        break
                    }
                }
        }
    }
}
