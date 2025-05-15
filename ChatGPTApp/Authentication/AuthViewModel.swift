//
//  AuthViewModel.swift
//  ChatGPTApp
//
//  Created by Andrew on 14.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    @Published var isLoading = false
    @Published var isPasswordVisible = false
    @Published var userExist = false
    
    let authService = AuthService()
    func authenticate(appState: AppState) {
        isLoading = true
        Task {
            do {
                if isPasswordVisible {
                    let result = try await authService.login(email: emailText, password: passwordText, userExist: userExist)
                    await MainActor.run(body: {
                        guard let result = result else { return }
                        //Update app state
                        appState.currentUser = result.user
                    })
                } else {
                    userExist = try await authService.checkUserExist(email: emailText)
                    isPasswordVisible = true
                }
                isLoading = false
            } catch {
                print(error)
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}
