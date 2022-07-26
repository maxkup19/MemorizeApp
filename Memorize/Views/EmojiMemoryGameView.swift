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
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                cardView(for: card)
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
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(3)
                .onTapGesture {
                    UISelectionFeedbackGenerator()
                        .selectionChanged()
                    game.choose(card)
                }
        }
    }
    
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20))
                        .padding(5)
                        .opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
        
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let linewidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(chosenTheme: .vehicles)
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(game: game)
//            .previewDevice("iPhone 13 mini")
//            .preferredColorScheme(.light)
//            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
