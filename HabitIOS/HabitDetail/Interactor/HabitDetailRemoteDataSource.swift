//
//  HabitDetailRemoteDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 10/06/26.
//
import Foundation
import Combine

class HabitDetailRemoteDataSource {
    
    // Padrao singleton
    // Temos 1 unico objeto vivo dentro da aplicacao
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init(){
        
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
        return Future<Bool, AppError> {promise in
            WebService.call(path: path, method: .post, body: request) { result in
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
                    promise(.success(true))
                    break
                }
            }
        }
    }
}

