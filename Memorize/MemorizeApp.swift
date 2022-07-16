//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
