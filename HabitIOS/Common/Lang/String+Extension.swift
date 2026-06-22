//
//  String+Extension.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//
import Foundation


extension String {
    
    func characterAtIndex (index: Int) -> Character? {
        var currency = 0
        
        // Para cada char na String
        for char in self {
            // Se o index for igual ao atual
            if currency == index {
                return char
            }
            currency = currency + 1
        }
        return nil
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func toDate(sourcePattern:String, destPattern: String) -> String?{
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = sourcePattern
        
        let dateFormatted = formatter.date(from: self)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = destPattern
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern:String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = sourcePattern
        
        return formatter.date(from: self)
    }
}
