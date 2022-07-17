//
//  Extension.swift
//  Memorize
//
//  Created by Max Kup on 17.07.2022.
//

import Foundation
import SwiftUI

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        }
        return nil
    }
}

extension Color {
    static func getFromString(name: String) -> Color {
        switch name {
        case "red":
            return .red
        case "green":
            return .green
        case "pink":
            return .pink
        case "blue":
            return .blue
        case "mint":
            return .mint
        case "purple":
            return .purple
        default:
            return .cyan
        }
    }
}
