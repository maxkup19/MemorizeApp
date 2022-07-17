//
//  ContentView.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Score: \(viewModel.gameScore)")
                    .font(.largeTitle)
                Spacer()
                Text("\(viewModel.name)" )
                    .font(.title2)
                    .foregroundColor(.getFromString(name: viewModel.color))
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                UISelectionFeedbackGenerator()
                                    .selectionChanged()
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.getFromString(name: viewModel.color))
            .padding(.horizontal)
            
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
                    .font(.largeTitle)
            }

        }
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
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
        
        ContentView(viewModel: game)
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
