//
//  SignUpRequest.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

// Encodable para transformar esse objeto em Json
struct SignUpRequest: Encodable {
    let fullname: String
    let email: String
    let document: String
    let phone: String
    let birthdate: String
    let password: String
    let gender: Int
    
    // Mapeando para montagem do Json esperado pelo servidor
    enum CodingKeys: String, CodingKey {
        case fullname = "name"
        case email
        case document
        case phone
        case birthdate = "birthday"
        case password
        case gender
    }
}
