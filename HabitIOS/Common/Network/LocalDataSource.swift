//
//  LocalDataSource.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 02/06/26.
//
import Foundation
import Combine

class LocalDataSource {
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init(){
        
    }
    
    private func saveValue(value: UserAuth){
        // Aqui encodamos o objeto que sera salvo no DB Local
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        // Se encontrarmos o objeto atraves da key
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            // Aqui decodamos o objeto salvo no DB Local
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth){
        // Aqui chega o objeto decodificado na etapa de login
        saveValue(value: userAuth)
    }
    
    // Aqui a gnt usa um never pq nao vai ter erro, ou volta um UserAuth diferente de nulo ou nulo
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        return Future { promisse in
            promisse(.success(userAuth))
        }
    }
}
