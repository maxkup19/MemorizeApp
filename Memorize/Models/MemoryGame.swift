//
//  MemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var unMatchedCards: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter ({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    var gameEnded: Bool {
        unMatchedCards == 0
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
                    if cards[chosenIndex].hasEarnedBonus {
                        score += 1
                    }
                    if cards[potentialIndex].hasEarnedBonus {
                        score += 1
                    }
                    unMatchedCards -= 1
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
                cards[chosenIndex].isFaceUp.toggle()
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {  cards.shuffle() }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        unMatchedCards = numberOfPairsOfCards
        //add numberOfPaitsOfCards * 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var alreadySeen = false
        
        let content: CardContent
        let id: Int
        
        
        //MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceTimeUp + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceTimeUp
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceTimeUp: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval { max(0, bonusTimeLimit - faceUpTime) }
        var bonusRemaining: Double { (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0 }
        var hasEarnedBonus: Bool { isMatched && bonusTimeRemaining > 0 }
        var isConsumingBonusTime: Bool { isFaceUp && !isMatched && bonusTimeRemaining > 0 }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceTimeUp = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
