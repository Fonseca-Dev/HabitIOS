//
//  ChartRemoteDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 17/06/26.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    
    // Padrao singleton
    // Temos 1 unico objeto vivo dentro da aplicacao
    
    static var shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    private init(){
        
    }
    
    func fecthHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
        return Future<[HabitValueResponse], AppError> {promise in
            WebService.call(path: path, method: .get) { result in
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
                case .success(let data):
                    let decoder = JSONDecoder()
                    let habitValuesResponse = try? decoder.decode([HabitValueResponse].self, from: data)
                    
                    guard let res = habitValuesResponse else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
}
