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
                        .background(RoundedRectangle(cornerRadius: 16) .fill(message.sender?.id == user.id ? Color.blue : Color.gray))
                        
                }
                if message.sender?.id != user.id {
                    Spacer()
                }
            }
        }
    }
}
