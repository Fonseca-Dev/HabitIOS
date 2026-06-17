//
//  HabitValueResponse.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 17/06/26.
//

struct HabitValueResponse : Decodable {
    let id: Int
    let value: Int
    let habitId:Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
    
}
