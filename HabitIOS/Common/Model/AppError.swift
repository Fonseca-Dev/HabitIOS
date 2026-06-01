//
//  AppError.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 01/06/26.
//

enum AppError: Error {
    case response(message:String)
    
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
