//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private var theme: CardTheme
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var name: String { theme.name }
    var emojis: [String] { theme.emojiSet }
    var color: String { theme.color }
    var numberOfCardsToShow: Int { theme.numberOfCardsToShow }
    var gameScore: Int { model.score }
    
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
        model = MemoryGame<String>(numberOfPairsOfCards: numberOfCardsToShow) { index in (theme.emojiSet[index])}
    }
    
}
