//
//  AuthView.swift
//  ChatGPTApp
//
//  Created by Andrew on 14.05.2025.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack {
            Text("Chat GPT iOS App")
                .font(.title)
                .bold()
            
            TextField("Email", text: $viewModel.emailText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            if viewModel.isPasswordVisible {
                SecureField("Password", text: $viewModel.passwordText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .textInputAutocapitalization(.never)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button {
                    viewModel.authenticate(appState: appState)
                } label: {
                    Text(viewModel.userExist ? "Login In" : "Create User")
                }
                .padding()
                .foregroundStyle(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
           
        }
        .padding()
    }
}

#Preview {
    AuthView()
}
