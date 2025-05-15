//
//  ContentView.swift
//  ChatGPTApp
//
//  Created by Andrew on 14.05.2025.
//

import SwiftUI

struct ContentView: View {
        var body: some View {
             NavigationStack {
                 ChatListView()
                     .navigationTitle("Chats")
                     .navigationDestination(for: String.self) { chatId in
                         ChatListView()
                     }
             }
        .padding()
    }
}

#Preview {
    ContentView()
}
