//
//  Gender.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

// CaseInterable -> Fara usar o ForEach, Identifiable -> Para Identificar cada elemento como unico
enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    case other = "Outros"
    
    var id: String {
        self.rawValue
    }
}
