//
//  MemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
        
    }
}
