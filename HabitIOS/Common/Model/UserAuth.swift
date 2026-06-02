//
//  UserAuth.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 02/06/26.
//

struct UserAuth: Codable {
    var idToken: String
    var refreshToken: String
    var expires: Int
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
