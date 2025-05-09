//
//  ViewModel.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//  Contributors: Matt Stoffel, Aditya Sharma, 
//

import Foundation
import Combine

@MainActor
class ViewModel: ObservableObject {
    @Published var threads: [Thread] = []
    @Published var messages: [Message] = []
    // MARK: – Typing state
    @Published var isTyping: Bool = false
    
    private let userHandler: UserHandler
    private let threadHandler: ThreadHandler
    private let messageHandler: MessageHandler
    private let enemyHandler: EnemyHandler
    
    let user: User
    
    init() {
        userHandler = UserHandler()
        threadHandler = ThreadHandler()
        messageHandler = MessageHandler()
        enemyHandler = EnemyHandler()
        user = userHandler.getOrCreateUser()
        loadThreads()
    }
    
    func loadThreads() {
        threads = threadHandler.fetchThreads(for: user)
    }
    
    func loadMessages(for thread: Thread) {
        DispatchQueue.main.async {
            self.messages = self.messageHandler.fetchMessages(for: thread)
        }
    }
    
    func createThread(with otherUserName: String) {
        threadHandler.createThread(for: user, called: otherUserName, with: userHandler.createUser(name: otherUserName))
        loadThreads()
    }
    
    func deleteThread(_ thread: Thread) {
        threadHandler.deleteThread(thread)
        loadThreads()
    }
    
    func addMessage(_ text: String, to thread: Thread) {
        // 1) save the user’s message
        messageHandler.addMessage(text: text, to: thread, sender: user)
        loadMessages(for: thread)

        // 2) launch the async AI fetch
        Task {
            await getEnemyResponse(to: thread)
        }
    }
    
//    func getEnemyResponse(to thread: Thread) {
//        var prompt: String = ""
//        for message in thread.messages?.allObjects as! [Message] {
//            prompt.append(message.text ?? "")
//        }
//        var enemyRespoonse: String = ""
//        Task {
//            await enemyRespoonse = enemyHandler.fetchStreamingResponse(question: prompt, enemyName: (thread.otherUser?.name)!)
//            messageHandler.addMessage(text: enemyRespoonse, to: thread, sender: thread.otherUser!)
//            loadMessages(for: thread)
//        }
//    }
    func getEnemyResponse(to thread: Thread) async {
        // 1) Build ordered prompt
        let allMsgs = (thread.messages?.allObjects as? [Message] ?? [])
            .sorted { ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast) }
        let prompt = allMsgs.compactMap { $0.text }.joined(separator: "\n")
        let enemyName = thread.otherUser?.name ?? "AI"

        // 2) Flip on spinner
        isTyping = true
        defer { isTyping = false }   // guarantee it always turns off

        // 3) Do the network call off the main thread…
        let response = await enemyHandler.fetchStreamingResponse(
            question: prompt,
            enemyName: enemyName
        )

        // 4) Back on MainActor (auto), save + reload
        messageHandler.addMessage(
            text: response,
            to: thread,
            sender: thread.otherUser!
        )
        loadMessages(for: thread)
    }
}
