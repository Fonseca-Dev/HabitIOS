//
//  SplashView.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 22/05/26.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                // Navegar para a proxima tela
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Carregar tela de home")
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: viewModel.onAppear)
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
        let viewModel = SplashViewModel()
        SplashView(viewModel: viewModel)
    }
}
