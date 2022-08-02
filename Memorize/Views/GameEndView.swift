//
//  GameEndView.swift
//  Memorize
//
//  Created by Max Kup on 02.08.2022.
//

import SwiftUI

struct GameEndView: View {
    
    @ObservedObject var game: EmojiMemoryGame
//    let finalScore: Int
    
    var body: some View {
        ZStack {
            game.gameScore < 0 ? Color.red : Color.green
 
            VStack {
                Group {
                    if game.gameScore <= 0 {
                        Text("YOU LOST\nScore: \(game.gameScore)")
                    } else  {
                        Text("YOU WON\nScore: \(game.gameScore)")
                    }
                }
                .padding()
                .font(.system(size: 64))
                
                Spacer()
                    .frame(maxHeight: 50)
                
                Button("New Game") {
                    game.newGame()
                }
                .padding()
                .foregroundColor(.blue)
                .background(Color.yellow)
                .font(.largeTitle)
                .clipShape(Capsule())
                    
            }
            
        }
        .ignoresSafeArea()
    }
    
}

//struct GameEndView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        GameEndView(finalScore: -12)
//    }
//}
