//
//  SignUpResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//

struct SignUpResponse: Decodable {
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
