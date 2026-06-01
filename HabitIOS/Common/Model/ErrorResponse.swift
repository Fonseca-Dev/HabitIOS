//
//  ErrorResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//

struct ErrorResponse: Decodable {
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
