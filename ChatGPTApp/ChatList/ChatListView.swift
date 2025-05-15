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
                            ChatRowView(chat: chat) {
                                viewModel.deleteChat(chat: chat)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Chats")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showProfile()
                } label: {
                    Image(systemName: "person")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.createChat()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        })
        .sheet(isPresented: $viewModel.isShowingProfileView) {
            ProfileView()
        }
        .navigationDestination(for: String.self, destination: { chatId in
            ChatView(viewModel: .init(chatId: chatId))})
        .onAppear {
            if viewModel.loadingState == .none {
                viewModel.fetchData()
            }
        }
    }
    
    struct ChatRowView: View {
        let chat: AppChat
        let onDelete: () -> Void
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(chat.topic ?? "New Chat")
                        .font(.headline)
                    Spacer()
                    Text(chat.model.rawValue)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(chat.model.tintColor)
                        .padding(6)
                        .background((chat.model.tintColor).opacity(0.1))
                        .clipShape(Capsule(style: .continuous))
                }
                Text(chat.lastMessageTimeAgo)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .swipeActions {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            }

        }
    }
}

#Preview {
    ChatListView()
}
