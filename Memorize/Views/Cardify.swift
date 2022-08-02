//
//  Cardify.swift
//  Memorize
//
//  Created by Max Kup on 31.07.2022.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    
    var rotation: Double // in degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0, y: 1, z: 0))
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
