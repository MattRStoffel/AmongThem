//
//  MessageHandler.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//

import Foundation
import CoreData

struct MessageHandler {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DatabaseHandler.shared.context) {
        self.context = context
    }
    
    func fetchMessages(for thread: Thread) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "thread == %@", thread)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func addMessage(text: String, to thread: Thread, sender: User) {
        guard !text.isEmpty else { return }
        let message = Message(context: context)
        message.id = UUID()
        message.text = text
        message.timestamp = Date()
        message.sender = sender
        message.thread = thread
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
