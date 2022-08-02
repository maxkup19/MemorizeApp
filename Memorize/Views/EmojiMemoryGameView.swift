//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
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
                
                gameBody
                deckBody
                
                HStack {
                    Button {
                        withAnimation {
                            game.newGame()
                            dealt = []
                        }
                    } label: {
                        Text("New")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            game.shuffle()
                        }
                    } label: {
                        Text("Shuffle")
                            .font(.largeTitle)
                            .colorInvert()
                    }
                }
                .padding(.horizontal)
                
            }
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) { dealt.insert(card.id) }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id  }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return .easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            cardView(for: card)
        }
        .foregroundColor(.getFromString(name: game.color))
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity , removal: .scale))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(.getFromString(name: game.color))
        .onTapGesture {
            //deal cards into ui
            
            for card in game.cards {
                withAnimation(dealAnimation(for: card )) {
                    deal(card)
                }
            }
        }
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) ||  (card.isMatched && !card.isFaceUp) {
            Color.clear
        } else {
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(3)
                .transition(.asymmetric(insertion: .opacity, removal: .scale))
                .onTapGesture {
                    UISelectionFeedbackGenerator()
                        .selectionChanged()
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else  {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                
                Text(card.content)
                    .font(font(in: geometry.size))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    
            }
            .cardify(isFaceup: card.isFaceUp)
        })
        
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        
    }
}
