//
//  Validation.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

struct Validation {
    
    static func mask(pattern: String, value: String) -> String {
        
        let numbers = Array(value.filter { $0.isNumber })
        var result = ""
        var index = 0
        
        for char in pattern {
            if index >= numbers.count { break }
            
            if char == "#" {
                result.append(numbers[index])
                index += 1
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
