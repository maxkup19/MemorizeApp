//
//  MemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter ({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    private(set) var score = 0
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialIndex].isMatched = true
                    
                    score += 2
                } else {
                    if cards[chosenIndex].alreadySeen {
                        score -= 1
                    }
                    if cards[potentialIndex].alreadySeen {
                        score -= 1
                    }
                    cards[chosenIndex].alreadySeen = true
                    cards[potentialIndex].alreadySeen = true
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
                
            cards[chosenIndex].isFaceUp.toggle()
        }
//        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        //add numberOfPaitsOfCards * 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var alreadySeen = false
        
        let content: CardContent
        let id: Int
    }
}
