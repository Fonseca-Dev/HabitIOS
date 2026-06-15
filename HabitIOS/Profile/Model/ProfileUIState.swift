//
//  ProfileUIState.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 12/06/26.
//

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fectchError(String)
    
    case udpdateLoading
    case updateSuccess
    case updateError(String)
}
