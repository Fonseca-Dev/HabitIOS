//
//  String+Extension.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import Foundation


extension String {
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
