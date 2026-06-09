//
//  HbitUIState.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

enum HabitUIState {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case failure(String)
}
