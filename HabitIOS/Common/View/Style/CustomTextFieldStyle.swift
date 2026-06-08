//
//  CustomTextFieldStyle.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 0.8)
            )
    }
}
