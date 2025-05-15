//
//  ChatViewModel.swift
//  ChatGPTApp
//
//  Created by Andrew on 15.05.2025.
//

import OpenAI
import Foundation


class ChatViewModel: ObservableObject {
    @Published var chat: AppChat?
    @Published var messages: [AppMessage] = []
    @Published var messageText: String = ""
    @Published var selectedModel: ChatModel = .gpt_3_5_turbo
    
    let chatId: String
    
    init(chatId: String) {
        self.chatId = chatId
    }
    
    func fetchData() {
        self.messages = [
            AppMessage(id: "1", text: "Hello hw are you? ", role: .user, createdAt: Date()),
            AppMessage(id: "2", text: "Im good, thanks!", role: .assistant, createdAt: Date())
        ]
    }
    
    func sendMessage() {
        var newMessage = AppMessage(id: UUID().uuidString, text: messageText, role: .user, createdAt: Date())
        messages.append(newMessage)
        messageText = ""
    }
}

enum Chat {
    enum Role: String, Codable, Hashable {
        case user
        case assistant
        case system
    }
}

struct AppMessage: Identifiable, Codable, Hashable {
    let id: String
    var text: String
    let role: Chat.Role
    let createdAt: Date
}
