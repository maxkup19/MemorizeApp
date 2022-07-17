//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Max Kup on 16.07.2022.
//

import Foundation

struct CardTheme {
    private(set) var name: String
    private(set) var emojiSet: [String]
    private(set) var color: String
    
    var numberOfCardsToShow: Int
    
    fileprivate static let vehicles = ["🚲", "🚂", "🚁", "🚜", "🚕" ,"🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚄"]
    
    fileprivate static let food = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶"]
    
    fileprivate static let hearts = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❤️‍🔥", "❤️‍🩹", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "😘", "😍", "🥰", "💟"]
    
    fileprivate static let flags = ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇺🇦", "🇦🇪", "🇬🇧", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🏴󠁧󠁢󠁳󠁣󠁴󠁿"]
    fileprivate static let activity = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🥊", "🥋", "🎽", "🛹", "🛼", "🛷", "⛸", "🥌", "🎿", "⛷", "🏂", "🪂"]
    fileprivate static let tech = ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "🗜", "💽", "💾", "📹", "🎥", "📽", "🎞", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙", "🎚", "🎛", "🧭", "⏱", "⏲", "⏰"]
}

enum Theme: CaseIterable {
    case hearts
    case food
    case vehicles
    case flags
    case activity
    case tech
    
    static func getTheme(theme: Theme) -> CardTheme {
        switch theme {
        case .hearts:
            return CardTheme(name: "Hearts", emojiSet: CardTheme.hearts.shuffled(), color: "pink", numberOfCardsToShow: Int.random(in: 4..<CardTheme.hearts.count))
        case .food:
            return CardTheme(name: "Food", emojiSet: CardTheme.food.shuffled(), color: "green", numberOfCardsToShow: Int.random(in: 4..<CardTheme.food.count))
        case .vehicles:
            return CardTheme(name: "Vehicles", emojiSet: CardTheme.vehicles.shuffled(), color: "blue", numberOfCardsToShow: Int.random(in: 4..<CardTheme.vehicles.count))
        case .flags:
            return CardTheme(name: "Flags", emojiSet: CardTheme.flags, color: "purple", numberOfCardsToShow: Int.random(in: 4..<CardTheme.flags.count))
        case .activity:
            return CardTheme(name: "Activity", emojiSet: CardTheme.activity, color: "mint", numberOfCardsToShow: Int.random(in: 4..<CardTheme.activity.count))
        case .tech:
            return CardTheme(name: "Tech", emojiSet: CardTheme.tech, color: "red", numberOfCardsToShow: Int.random(in: 4..<CardTheme.tech.count))
        }
    }
}
