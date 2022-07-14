//
//  MemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    func choose(card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //add numberOfPaitsOfCards * 2 cards to array
        for pairIndex in 0...numberOfPairsOfCards {
            let content = createCardContent(pairIndex )
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        
    }
}
