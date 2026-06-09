//
//  Date+Extension.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 09/06/26.
//

import Foundation

extension Date {
    func toString(destPattern: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = destPattern
        return formatter.string(from: self)
    }
}
