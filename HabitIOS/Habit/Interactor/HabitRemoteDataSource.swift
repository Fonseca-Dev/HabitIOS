//
//  HabitRemoteDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//
import Foundation
import Combine

class HabitRemoteDataSource {
    
    // Padrao singleton
    // Temos 1 unico objeto vivo dentro da aplicacao
    
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init(){
        
    }
    
    func fecthHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError> {promise in
            WebService.call(
                path: .habits,
                method: .get){ result in
                    switch result {
                    case .failure(_, let data):
                        if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                        break
                    case .success(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode([HabitResponse].self, from: data)
                        //completion(response, nil)
                        guard let res = response else {
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

