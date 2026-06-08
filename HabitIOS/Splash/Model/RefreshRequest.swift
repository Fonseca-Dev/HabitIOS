//
//  RefreshRequest.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 02/06/26.
//

struct RefreshRequest :  Encodable{
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
