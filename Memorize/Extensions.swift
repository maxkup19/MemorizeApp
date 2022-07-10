//
//  Extensions.swift
//  Memorize
//
//  Created by Max Kup on 10.07.2022.
//

import Foundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
