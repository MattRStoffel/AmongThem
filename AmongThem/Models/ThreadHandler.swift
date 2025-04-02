//
//  ThreadHandler.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//

import Foundation
import CoreData

struct ThreadHandler {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DatabaseHandler.shared.context) {
        self.context = context
    }
    
    func fetchThreads(for user: User) -> [Thread] {
        let request: NSFetchRequest<Thread> = Thread.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func createThread(for user: User, called title: String, with otherUser: User) {
        let thread = Thread(context: context)
        thread.id = UUID()
        thread.user = user
        thread.otherUser = otherUser
        thread.title = title
        
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
