//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    var theme: CardTheme
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    
    init(chosenTheme: Theme) {
        self.theme = Theme.getTheme(theme: chosenTheme)
        model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardsToShow) { index in (Theme.getTheme(theme: chosenTheme).emojiSet[index])}
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        self.theme = Theme.getTheme(theme: Theme.allCases.randomElement()!)
        model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardsToShow) { index in (theme.emojiSet[index])}
    }
    
}
