//
//  DataBase.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//

import Foundation
import CoreData

class DatabaseHandler {
    static let shared = DatabaseHandler()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
