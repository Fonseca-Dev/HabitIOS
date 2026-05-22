//
//  SignInView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(.blue)
    }
}

#Preview {
    let viewModel = SignInViewModel()
    SignInView(viewModel: viewModel)
}
