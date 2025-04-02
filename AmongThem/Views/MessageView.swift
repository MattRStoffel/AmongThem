//
//  MessageView.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/28/25.
//

import SwiftUI
struct MessageView: View {
    let message: Message
    let user: User
    
    var body: some View {
        if let text = message.text {
            HStack {
                if message.sender?.id == user.id {
                    Spacer()
                }
                ZStack {
                    Text(text)
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(message.sender?.id == user.id ? .blue : .green)
                }
                if message.sender?.id != user.id {
                    Spacer()
                }
            }
        }
    }
}
