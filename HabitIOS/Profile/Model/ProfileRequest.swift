//
//  ProfileRequest.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 15/06/26.
//

// Encodable para transformar esse objeto em Json
struct ProfileRequest: Encodable {
    let fullname: String
    let phone: String
    let birthdate: String
    let gender: Int
    
    // Mapeando para montagem do Json esperado pelo servidor
    enum CodingKeys: String, CodingKey {
        case fullname = "name"
        case phone
        case birthdate = "birthday"
        case gender
    }
}
