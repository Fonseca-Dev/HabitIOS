//
//  ProfileResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 12/06/26.
//

// Encodable para transformar esse objeto em Json
struct ProfileResponse: Decodable {
    
    let id: Int
    let fullname: String
    let email: String
    let document: String
    let phone: String
    let birthdate: String
    let gender: Int
    
    // Mapeando para montagem do Json esperado pelo servidor
    enum CodingKeys: String, CodingKey {
        case id
        case fullname = "name"
        case email
        case document
        case phone
        case birthdate = "birthday"
        case gender
    }
}
