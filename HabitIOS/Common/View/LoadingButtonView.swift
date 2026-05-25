//
//  LoadingButtonView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import SwiftUI

struct LoadingButtonView: View {
    var action: () -> Void
    var text: String
    var disabled: Bool = false
    var showProgressBar: Bool = false
    
    var body: some View {
        ZStack{
            Button {
                action()
            } label: {
                Text(showProgressBar ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
                
            }.disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgressBar ? 1 : 0)
        }
    }
}

#Preview("Light") {
    VStack{
        LoadingButtonView(
            action: {
                print("Clicou!")
            },
            text : "Teste",
            disabled: false,
            showProgressBar: true,
        )
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .preferredColorScheme(.dark)
}
