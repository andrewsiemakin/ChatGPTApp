//
//  ChatGPTAppApp.swift
//  ChatGPTApp
//
//  Created by Andrew on 14.05.2025.
//

import SwiftUI

@main
struct ChatGPTAppApp: App {
    
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                NavigationStack(path: $appState.navigationPath) {
                    ChatListView()
                        .environmentObject(appState)
                }
            } else {
                AuthView()
                    .environmentObject(appState)
            }

        }
    }
}
