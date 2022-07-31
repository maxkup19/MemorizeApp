//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by Max Kup on 14.07.2022.
//

import SwiftUI

let heartsTheme = CardTheme(name: "Hearts", emojiSet: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❤️‍🔥", "❤️‍🩹", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "😘", "😍", "🥰", "💟"].shuffled(), color: "pink", numberOfCardsToShow: 5)

let vehiclesTheme = CardTheme(name: "Vehicles", emojiSet: ["🚲", "🚂", "🚁", "🚜", "🚕" ,"🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚄"].shuffled(), color: "blue", numberOfCardsToShow: 12)

let foodTheme = CardTheme(name: "Food", emojiSet: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶"].shuffled(), color: "green", numberOfCardsToShow: 9)

let flagsTheme = CardTheme(name: "Flags", emojiSet: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇺🇦", "🇦🇪", "🇬🇧", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🏴󠁧󠁢󠁳󠁣󠁴󠁿"].shuffled(), color: "purple", numberOfCardsToShow: 22)

let activityTheme = CardTheme(name: "Activity", emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🥊", "🥋", "🎽", "🛹", "🛼", "🛷", "⛸", "🥌", "🎿", "⛷", "🏂", "🪂"].shuffled(), color: "mint", numberOfCardsToShow: 4)

let techTheme = CardTheme(name: "Tech", emojiSet: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "🗜", "💽", "💾", "📹", "🎥", "📽", "🎞", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙", "🎚", "🎛", "🧭", "⏱", "⏲", "⏰"].shuffled(), color: "red", numberOfCardsToShow: 6)

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
        model = MemoryGame<String>(numberOfPairsOfCards: numberOfCardsToShow) { index in (theme.emojiSet[index])}
    }
}

struct CardTheme {
    let name: String
    private(set) var emojiSet: [String]
    let color: String
    var numberOfCardsToShow: Int
}
