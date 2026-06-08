//
//  ButtonStyle.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 08/06/26.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
    }
}
