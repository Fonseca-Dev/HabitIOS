//
//  SplashView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var state: SplashUiState = .error("Teste de erro no servidor.")
    
    var body: some View {
        switch state {
        case .loading:
            loadingView()
        case .goToSignInScreen:
            Text("Carregar tela de login")
        case .goToHomeScreen:
            Text("Carregar tela de home")
        case .error(let msg):
            loadingView(error: msg)
        }
    }
}

// 1. Compartilhamento | objetos
struct LoadingView: View {
    var body: some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(.white)
                .ignoresSafeArea()
        }
    }
}

// 2. Variaveis em extensions
extension SplashView {
    var loadinh: some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(.white)
                .ignoresSafeArea()
        }
    }
}

// 3. Funcoes em extensios
extension SplashView{
    func loadingView(error: String? = nil) -> some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                            // Faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

#Preview {
    Group {
        SplashView()
    }
}
