//
//  ChatListView.swift
//  ChatGPTApp
//
//  Created by Andrew on 15.05.2025.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                Text("Loading chats...")
            case .noResults:
                Text("Loading chats...")
            case .resultFound:
                List {
                    ForEach(viewModel.chats) { chat in
                        NavigationLink(value: chat.id) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(chat.topic ?? "New Chat")
                                        .font(.headline)
                                    Spacer()
                                    Text(chat.model.rawValue ?? "")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(chat.model.tintColor ?? .white)
                                        .padding(6)
                                        .background((chat.model.tintColor ?? .white).opacity(0.1))
                                        .clipShape(Capsule(style: .continuous))
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if viewModel.loadingState == .none {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ChatListView()
}
