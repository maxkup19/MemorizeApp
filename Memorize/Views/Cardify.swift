//
//  Cardify.swift
//  Memorize
//
//  Created by Max Kup on 31.07.2022.
//

import SwiftUI

struct Cardify: ViewModifier {

    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let linewidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceup: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceup))
    }
}
