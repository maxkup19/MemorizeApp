//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import SwiftUI

let heartsTheme = CardTheme(name: "Hearts", emojiSet: ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐", "๐ค", "๐ค", "๐ค", "๐", "โค๏ธโ๐ฅ", "โค๏ธโ๐ฉน", "โฃ๏ธ", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ฅฐ", "๐"].shuffled(), color: "pink", numberOfCardsToShow: 5)

let vehiclesTheme = CardTheme(name: "Vehicles", emojiSet: ["๐ฒ", "๐", "๐", "๐", "๐" ,"๐", "๐", "๐", "๐", "โ๏ธ", "๐", "โต๏ธ", "๐ธ", "๐ถ", "๐", "๐", "๐บ", "๐ ", "๐ต", "๐", "๐", "๐", "๐ป", "๐"].shuffled(), color: "blue", numberOfCardsToShow: 12)

let foodTheme = CardTheme(name: "Food", emojiSet: ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ซ", "๐", "๐", "๐", "๐ฅญ", "๐", "๐ฅฅ", "๐ฅ", "๐", "๐", "๐ฅ", "๐ฅฆ", "๐ฅฌ", "๐ฅ", "๐ถ"].shuffled(), color: "green", numberOfCardsToShow: 9)

let flagsTheme = CardTheme(name: "Flags", emojiSet: ["๐ฆ๐ซ", "๐ฆ๐ฝ", "๐ฆ๐ฑ", "๐ฉ๐ฟ", "๐ฆ๐ธ", "๐ฆ๐ฉ", "๐ฆ๐ด", "๐ฆ๐ฎ", "๐ฆ๐ถ", "๐ฆ๐ฌ", "๐ฆ๐ท", "๐ฆ๐ฒ", "๐ฆ๐ผ", "๐ฆ๐บ", "๐ฆ๐น", "๐ฆ๐ฟ", "๐ง๐ธ", "๐ง๐ญ", "๐ง๐ฉ", "๐ง๐ง", "๐ง๐พ", "๐บ๐ฆ", "๐ฆ๐ช", "๐ฌ๐ง", "๐ด๓ ง๓ ข๓ ฅ๓ ฎ๓ ง๓ ฟ", "๐ด๓ ง๓ ข๓ ณ๓ ฃ๓ ด๓ ฟ"].shuffled(), color: "purple", numberOfCardsToShow: 22)

let activityTheme = CardTheme(name: "Activity", emojiSet: ["โฝ๏ธ", "๐", "๐", "โพ๏ธ", "๐ฅ", "๐พ", "๐", "๐", "๐ฅ", "๐ฑ", "๐ช", "๐", "๐ธ", "๐", "๐ฅ", "๐ฅ", "๐ฝ", "๐น", "๐ผ", "๐ท", "โธ", "๐ฅ", "๐ฟ", "โท", "๐", "๐ช"].shuffled(), color: "mint", numberOfCardsToShow: 4)

let techTheme = CardTheme(name: "Tech", emojiSet: ["โ๏ธ", "๐ฑ", "๐ป", "โจ๏ธ", "๐ฅ", "๐จ", "๐ฑ", "๐ฒ", "๐น", "๐", "๐ฝ", "๐พ", "๐น", "๐ฅ", "๐ฝ", "๐", "๐", "โ๏ธ", "๐", "๐ ", "๐บ", "๐ป", "๐", "๐", "๐", "๐งญ", "โฑ", "โฒ", "โฐ"].shuffled(), color: "red", numberOfCardsToShow: 6)

let gameThemes = [heartsTheme, vehiclesTheme, foodTheme, flagsTheme, activityTheme, techTheme]
let initialTheme = vehiclesTheme

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private var theme: CardTheme
    @Published private var model: MemoryGame<String>
    
    var cards: Array<Card> { model.cards }
    var name: String { theme.name }
    var emojis: [String] { theme.emojiSet }
    var color: String { theme.color }
    var numberOfCardsToShow: Int { theme.numberOfCardsToShow }
    var gameScore: Int { model.score }
    var ended: Bool { model.gameEnded }
    
    init() {
        theme = initialTheme
        model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardsToShow) { index in initialTheme.emojiSet[index] }
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        theme = gameThemes.randomElement()!
        theme.numberOfCardsToShow = Int.random(in: 4...theme.emojiSet.count)
        model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardsToShow) { index in theme.emojiSet[index] }
    }
    
    func shuffle() { model.shuffle() }
}

struct CardTheme {
    let name: String
    private(set) var emojiSet: [String]
    let color: String
    var numberOfCardsToShow: Int
}
