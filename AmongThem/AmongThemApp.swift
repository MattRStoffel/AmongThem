//
//  AmongThemApp.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//

import SwiftUI

@main
struct AmongThemApp: App {
    @State private var showMenu = true // Track whether the menu view or content view is shown
        
        var body: some Scene {
            WindowGroup {
                if showMenu {
                    MenuView(showMenu: $showMenu) // Pass the state variable to MenuView
                } else {
                    ContentView( viewModel: ViewModel(), showMenu: $showMenu) // Show ContentView when showMenu is false
                }
            }
        }
}
