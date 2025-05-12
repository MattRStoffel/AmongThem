//
//  ThreadDetailView.swift
//  AmongThem
//
//  Created by Aditya Sharma on 5/9/25.
//  Contributors: Matt Stoffel, Aditya Sharma,
//


import SwiftUI

struct ThreadDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var thread: Thread

    var body: some View {
        ZStack {
            Image("Space")
                .resizable()
                .edgesIgnoringSafeArea(.all)
    
            VStack(spacing: 0) {
                ZStack {
                    Color.clear
                        .frame(height: 50)

                    Text(thread.otherUser?.name ?? "AI")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, -65) // adjust closer to status bar if needed
                .zIndex(1) // make sure it floats above background
                
                
                messagesSection.padding(.bottom, 5)

                UserInput { text in
                    viewModel.addMessage(text, to: thread)
                }
            }
            .onAppear {
                viewModel.loadMessages(for: thread)
            }
            .padding()
        }
    }
}

extension ThreadDetailView {
    // MARK: – Messages + Indicators
    private var messagesSection: some View {
        ScrollViewReader { proxy in
            messageList(proxy: proxy)
                // scroll when a new persisted message arrives
                .onChange(of: viewModel.messages.count) { _ in
                    scrollToLast(proxy)
                }
                // scroll when the static “is typing…” indicator appears
                .onChange(of: viewModel.isTyping) { _ in
                    scrollToTyping(proxy)
                }
                // scroll once streaming begins (to show the draft bubble)
                .onChange(of: viewModel.isStreaming) { streaming in
                    if streaming {
                        // first scroll to the draft as tokens arrive
                        scrollToDraft(proxy)
                    } else {
                        // once streaming ends, scroll to the final message
                        scrollToLast(proxy)
                    }
                }
                // ★ scroll on each new token
                .onChange(of: viewModel.draftText) { _ in
                    scrollToDraft(proxy)
                }
        }
    }


    private func messageList(proxy: ScrollViewProxy) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                // 1) Real messages
                ForEach(viewModel.messages) { msg in
                    MessageView(message: msg, user: viewModel.user)
                        .id(msg.id)
                }

                // 2) Static “is typing…” indicator
                if viewModel.isTyping {
                    HStack(spacing: 8) {
                        ProgressView()
                            .scaleEffect(0.75)
                            .tint(.white)
                        Text("\(thread.otherUser?.name ?? "AI") is typing…")
                            .italic()
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .opacity(0.9)
                    }
                    .padding(.vertical, 4)
                    .transition(.opacity)
                    .id("typingIndicator")
                }

                // 3) Streaming draft bubble
                if viewModel.isStreaming {
                    HStack {
                        ZStack {
                            Text(viewModel.draftText)
                              .bold()
                              .padding()
                              .foregroundStyle(.white)
                              .background(
                                    RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray)
                              )
                        }
                        Spacer()
                    }
                .padding(.horizontal)
                .id("draftIndicator")
                }
            }
//            .padding(.horizontal)
        }
    }

    // MARK: – Scrolling helpers
    private func scrollToLast(_ proxy: ScrollViewProxy) {
        guard let last = viewModel.messages.last?.id else { return }
        withAnimation {
            proxy.scrollTo(last, anchor: .bottom)
        }
    }

    private func scrollToTyping(_ proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("typingIndicator", anchor: .bottom)
        }
    }

    private func scrollToDraft(_ proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("draftIndicator", anchor: .bottom)
        }
    }
}
