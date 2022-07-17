//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = EmojiMemoryGame(chosenTheme: Theme.allCases.randomElement()!)
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
