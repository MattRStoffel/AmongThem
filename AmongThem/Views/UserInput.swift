//
//  UserInput.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/28/25.
//

import SwiftUI

struct UserInput: View {
    let onSend: (String) -> Void
    @State var input: String = ""
    var body: some View {
        HStack {
            TextField("Very AI Message", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    onSend(input)
                    input = ""
                }
            if !input.isEmpty {
                Button(action: {
                    onSend(input)
                    input = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal)
    }
}
