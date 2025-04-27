//
//  ContentView.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var newThreadTitle: String = ""
    @Binding var showMenu: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    ForEach(viewModel.threads) { thread in
                        NavigationLink(value: thread) {
                            Text(thread.title ?? "Untitled Thread")
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.createThread(with: "bot")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "arrow.left.circle")
                    }
                    
                }
            }
            .navigationDestination(for: Thread.self) { thread in
                ThreadDetailView(viewModel: viewModel, thread: thread)
            }
        }
    }
}

struct ThreadDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var thread: Thread

    var body: some View {
        ZStack {
            Image("Space")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message, user: viewModel.user)
                    }
                }
                UserInput { text in
                    viewModel.addMessage(text, to: thread)
                    viewModel.getEnemyResponse(to: thread)
                }
            }
            .onAppear {
                viewModel.loadMessages(for: thread)
            }
            .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView(viewModel: ViewModel(), showMenu: .constant(true))
        }
}
