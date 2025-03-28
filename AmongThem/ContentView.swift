//
//  ContentView.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//

import SwiftUI

struct MessageView: View {
    let message: Model.Message
    var body: some View {
        HStack {
            if message.sender {
                Spacer()
            }
            ZStack {
                Text(message.content)
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(message.sender ? .blue : .green)
            }
            if !message.sender {
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var input: String = ""
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.getMessages()) { m in
                        MessageView(message: m)
                            .id(m.id)
                    }
                }
                .onChange(of: viewModel.getMessages().count) { _, _ in
                    if let lastMessage = viewModel.getMessages().last {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            HStack {
                TextField("Very Human Message", text: $input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(content: input, sender: true)
                    input = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
