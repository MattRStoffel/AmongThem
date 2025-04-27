//
//  MenuView.swift
//  AmongThem
//
//  Created by Steven Brandt on 4/26/25.
//
import SwiftUI


struct MenuView: View {
    @Binding var showMenu: Bool // Binding to change the root view
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Space")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("KnockOff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200) // Adjust size
                    
                    Text("AmongThem")
                        .font(.custom("Noteworthy", size: 40))
                        
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.white)
                        

                    // NavigationLink to navigate to ContentView, change showMenu to false when navigating
                    Button(action: {
                        showMenu.toggle()// Switch to ContentView
                    }) {
                        Text("Play")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(minHeight: 60)
                    }
                    
                    // Optionally add more links (e.g., Help)
                    NavigationLink(destination: HelpView()) {
                        Text("Help")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame( minHeight: 60)
                    }
                }
            }
            }
            
    
    }
}
