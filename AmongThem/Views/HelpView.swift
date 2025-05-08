//
//  HelpView.swift
//  AmongThem
//
//  Created by Makoa Brandt on 4/26/25.
//
import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            Image("Space")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Text("Click on the + button in order to make a new character, once made talk to the new person in the chat. Make a remark and they will explain their setting. Once done with the chat delete the thread by swiping left on it. For a fun game click person")
                .padding(20)
                .background(.gray)
                .foregroundColor(.white)
        }
        }
        
}
