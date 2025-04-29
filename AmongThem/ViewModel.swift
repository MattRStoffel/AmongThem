//
//  ViewModel.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var threads: [Thread] = []
    @Published var messages: [Message] = []
    
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
        messageHandler.addMessage(text: text, to: thread, sender: user)
        loadMessages(for: thread)
    }
    
    func getEnemyResponse(to thread: Thread) {
        var prompt: String = ""
        for message in thread.messages?.allObjects as! [Message] {
            prompt.append(message.text ?? "")
        }
        var enemyRespoonse: String = ""
        Task {
            await enemyRespoonse = enemyHandler.fetchStreamingResponse(question: prompt, enemyName: (thread.otherUser?.name)!)
            messageHandler.addMessage(text: enemyRespoonse, to: thread, sender: thread.otherUser!)
            loadMessages(for: thread)
        }
    }
}
