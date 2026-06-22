//
//  Mask.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 21/06/26.
//

import Foundation

class Mask {
    
    static var isUpdating: Bool = false
    static var oldString: String = ""
    
    // Primeiro paramentro -> para saber o tipo de mascara que vai ser aplicado
    // Segundo parametro -> é o valor que esta em mudanca no campo
    // Terceiro parametro -> é o valor que esta sendo armazenado para mostrar no campo apos mascaramento
    // O inout é como se fosse o Binding só que para variaveis mais simples
    static func mask(mask: String, value: String, text: inout String){
        let str = replaceChars(full: value)
        var cpfWithMask = ""
        
        var _mask = mask
        if (_mask == "(##) ####-####") {
            if (value.count >= 14 && value.characterAtIndex(index: 5) == "9"){
                _mask = "(##) #####-####"
            }
        }
        
        // Se o valor que eu digitei for maior que a antiga
        if (str <= oldString){ // estou deletando
            if (mask == "(## ####-####)" && value.count == 14) {
                (_mask = "(##) #####-####")
            }
            isUpdating = true
        }
        
        // Se tiver atualizando ou o numero de contagem ja bateu a tde da mascara
        // Significa que paoru de digitar
        if (isUpdating || value.count == mask.count) {
            oldString = str
            isUpdating = false
            return
        }
        
        var index = 0
        
        for char in _mask {
            if (char != "#" && str.count > oldString.count) {
                cpfWithMask.append(char)
                continue
            }
            
            let unamed = str.characterAtIndex(index: index)
            guard let char = unamed else {break}
            
            cpfWithMask.append(char)
            
            index = index + 1
            
        }
        
        isUpdating = true
        
        if (cpfWithMask == "(0") {
            text = ""
            return
        }
        
        text = cpfWithMask
    }
    
    private static func replaceChars(full: String) -> String {
        full.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
}
