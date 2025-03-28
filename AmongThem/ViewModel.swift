//
//  ViewModel.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//

import Foundation

class ViewModel: ObservableObject {
    
    static func startGame() -> Model {
        return Model()
    }
    
    @Published private var model: Model = startGame()
    
    func getMessages() -> [Model.Message] {
        return model.messages
    }
    
    func sendMessage(content: String, sender: Bool) {
        model.addMessage(content: content, sender: sender)
    }
}
