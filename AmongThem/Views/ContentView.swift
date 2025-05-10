//
//  ContentView.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//  Contributors: Matt Stoffel, Aditya Sharma, 
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
//    @State private var newThreadTitle: String = ""
    @Binding var showMenu: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    ForEach(viewModel.threads) { thread in
                        NavigationLink(value: thread) {
                            Text(thread.title ?? "Untitled Thread")
                        }
                    }.onDelete(perform: deleteThread)
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            viewModel.createThread(with: "person")
                        } label: {
                            Text("person")
                        }
                        Button{
                            viewModel.createThread(with: "Dietian")
                        } label: {
                            Text("Dietian")
                        }
                        Button{
                            viewModel.createThread(with: "Fitness Coach")
                        } label: {
                            Text("Fitness Coach")
                        }
                        Button{
                            viewModel.createThread(with: "Doctor")
                        } label: {
                            Text("Doctor")
                        }
                        Button{
                            viewModel.createThread(with: "Therapist")
                        } label:{
                            Text("Therapist")
                        }
                        Button{
                            viewModel.createThread(with: "Gaslight")
                        } label:{
                            Text("Gaslight")
                        }
                        Button {
                            let randomNumber = Int.random(in: 1...5)
                            var name = "Unknown"
                            switch randomNumber {
                            case 1:
                                name = "Dietian"
                            case 2:
                                name = "Fitness Coach"
                            case 3:
                                name = "Doctor"
                            case 4:
                                name = "Therapist"
                            default :
                                break
                            }
                            viewModel.createThread(with: name)
                        } label: {
                            Text("Random Help")
                        }
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
    
    func deleteThread(at offsets: IndexSet) {
        for index in offsets {
            let thread = viewModel.threads[index]
            viewModel.deleteThread(thread)
        }
    }
}

//struct ThreadDetailView: View {
//    @ObservedObject var viewModel: ViewModel
//    var thread: Thread
//
//    var body: some View {
//        ZStack {
//            Image("Space")
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                ScrollView {
//                    ForEach(viewModel.messages) { message in
//                        MessageView(message: message, user: viewModel.user)
//                    }
//                    if viewModel.isTyping {
//                      HStack {
//                        ProgressView().scaleEffect(0.75)
//                        Text("\(thread.otherUser?.name ?? "AI") is typing…")
//                          .italic()
//                          .foregroundColor(.white)
//                      }
//                    }
//                }
//                UserInput { text in
//                    viewModel.addMessage(text, to: thread)
//                }
//            }
//            .onAppear {
//                viewModel.loadMessages(for: thread)
//            }
//            .padding()
//        }
//
//    }
//}

//struct ThreadDetailView: View {
//    @ObservedObject var viewModel: ViewModel
//    var thread: Thread
//
//    var body: some View {
//        ZStack {
//            Image("Space")
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//
//            VStack {
//                messagesSection
//
//                    UserInput { text in
//                        viewModel.addMessage(text, to: thread)
//                    }
//                }
//                .onAppear { viewModel.loadMessages(for: thread) }
//                .padding()
//            }
//        }
//
//        // MARK: – Messages + Indicators
//        private var messagesSection: some View {
//            ScrollViewReader { proxy in
//                ScrollView {
//                    LazyVStack(spacing: 12) {
//                        // 1) Real messages
//                        ForEach(viewModel.messages) { msg in
//                            MessageView(message: msg, user: viewModel.user)
//                                .id(msg.id)
//                        }
//
//                        // 2) Static “is typing…” indicator
//                        if viewModel.isTyping {
//                            HStack(spacing: 8) {
//                                ProgressView()
//                                    .scaleEffect(0.75)
//                                    .tint(.white)
//                                Text("\(thread.otherUser?.name ?? "AI") is typing…")
//                                    .italic()
//                                    .font(.subheadline)
//                                    .fontWeight(.medium)
//                                    .foregroundColor(.white)
//                                    .opacity(0.9)
//                            }
//                            .padding(.vertical, 4)
//                            .transition(.opacity)
//                            .id("typingIndicator")
//                        }
//
//                        // 3) Streaming draft bubble
//                        if viewModel.isStreaming {
//                            MessageView(
//                                text: viewModel.draftText,
//                                isFromUser: false,
//                                isDraft: true
//                            )
//                            .id("draftIndicator")
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .onChange(of: viewModel.messages.count) { _ in
//                    guard let last = viewModel.messages.last?.id else { return }
//                    withAnimation { proxy.scrollTo(last, anchor: .bottom) }
//                }
//                .onChange(of: viewModel.isTyping) { typing in
//                    if typing {
//                        withAnimation { proxy.scrollTo("typingIndicator", anchor: .bottom) }
//                    }
//                }
//                .onChange(of: viewModel.isStreaming) { streaming in
//                    if streaming {
//                        withAnimation { proxy.scrollTo("draftIndicator", anchor: .bottom) }
//                    }
//                }
//            }
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView(viewModel: ViewModel(), showMenu: .constant(true))
        }
}

