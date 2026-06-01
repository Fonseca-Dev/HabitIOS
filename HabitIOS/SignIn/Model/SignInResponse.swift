//
//  SignInResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//

struct SignInResponse : Decodable {
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
