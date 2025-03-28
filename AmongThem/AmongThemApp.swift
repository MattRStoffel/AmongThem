//
//  AmongThemApp.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/27/25.
//

import SwiftUI

@main
struct AmongThemApp: App {
    var body: some Scene {
        WindowGroup {
            var viewModel = ViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
