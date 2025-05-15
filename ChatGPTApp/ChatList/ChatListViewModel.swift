//
//  ChatListVeiwModel.swift
//  ChatGPTApp
//
//  Created by Andrew on 15.05.2025.
//

import Foundation
import SwiftUI

class ChatListViewModel: ObservableObject {
    @Published var chats: [AppChat] = []
    @Published var loadingState: ChatListState = .none
    @Published var isShowingProfileView = false
    func fetchData() {
        self.chats = [
            AppChat(id: "1", topic: "Some topic", model: .gpt_3_5_turbo, lastMessageSent: Date(), owner: "Bill"),
            AppChat(id: "2", topic: "Some other topic", model: .gpt4, lastMessageSent: Date(), owner: "John")
        ]
        self.loadingState = .resultFound
    }
    
    func createChat() {
        
    }

    
    func showProfile() {
        isShowingProfileView = true
    }
    
    func deleteChat(chat: AppChat) {
        
    }
}

enum ChatListState {
    case none
    case loading
    case noResults
    case resultFound
}

struct AppChat: Codable, Identifiable {
    let id: String
    let topic: String?
    let model: ChatModel
    let lastMessageSent: Date
    let owner: String
    
    var lastMessageTimeAgo: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.second, .hour, .day, .month, .year], from: lastMessageSent, to: now)
        
        let timeUnits: [(value: Int?, unit: String?)] = [
            (components.year, "year"),
            (components.month, "month"),
            (components.day, "day"),
            (components.hour, "hour"),
            (components.minute, "minute"),
            (components.second, "second"),
        ]
        
        for timeUnit in timeUnits {
            if let value = timeUnit.value, value > 0 {
                return "\(value) \(String(describing: timeUnit.unit))\(value == 1 ? "" : "s" )"
            }
        }
        
        return "just now"
    }
    
   
}

enum ChatModel: String, Codable, CaseIterable, Hashable {
    case gpt_3_5_turbo = "GPT 3.5 Turbo"
    case gpt4 = "GPT 4"
    
    var tintColor: Color {
        switch self {
        case .gpt_3_5_turbo:
            return .green
        case .gpt4:
            return .purple
        }
    }
}
