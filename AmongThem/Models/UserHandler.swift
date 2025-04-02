//
//  UserHandler.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//

import Foundation
import CoreData

struct UserHandler {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DatabaseHandler.shared.context) {
        self.context = context
    }
    
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print(error)
            return nil
        }
    }
    
    func createUser(name: String) -> User {
        let user = User(context: context)
        user.id = UUID()
        user.name = name
        saveContext()
        return user
    }
    
    func getOrCreateUser() -> User {
        if let user = fetchUser() {
            return user
        }
        return createUser(name: "me")
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
