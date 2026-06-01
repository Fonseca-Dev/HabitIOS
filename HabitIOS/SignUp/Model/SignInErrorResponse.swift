//
//  SignInErrorResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
