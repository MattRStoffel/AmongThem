//
//  Model.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//

import Foundation

struct Model {
    struct Message: Identifiable{
        let content: String
        let sender: Bool
        let id: UUID
        init(content: String, sender: Bool) {
            self.content = content
            self.sender = sender
            self.id = UUID()
        }
    }
    
    var messages: [Message] = [
        Message(content:"Hello", sender:false),
        Message(content:"Hi", sender:true),
        Message(content:"How are you", sender:false),
        Message(content:"Good thanks", sender:true),
        Message(content:"Cool....", sender:false),
        Message(content:"Cool", sender:true)
    ]
    
    mutating func addMessage(content: String, sender: Bool) {
        messages.append(Message(content: content, sender: sender))
    }
}
