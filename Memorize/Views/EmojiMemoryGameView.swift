//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Score: \(game.gameScore)")
                    .font(.largeTitle)
                Spacer()
                Text("\(game.name)" )
                    .font(.title2)
                    .foregroundColor(.getFromString(name: game.color))
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                UISelectionFeedbackGenerator()
                                    .selectionChanged()
                                game.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.getFromString(name: game.color))
            .padding(.horizontal)
            
            Button {
                game.newGame()
            } label: {
                Text("New Game")
                    .font(.largeTitle)
            }

        }
    }
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(chosenTheme: .vehicles)
        
        EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
