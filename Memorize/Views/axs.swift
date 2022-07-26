//
//  axs.swift
//  Memorize
//
//  Created by Max Kup on 17.07.2022.
//

import SwiftUI

struct axs: View {
    var body: some View {
        HStack{
            Text("Important").layoutPriority(100)
            Image(systemName: "arrow.up")
            Text("Unimportant")
        }
    }
}

struct axs_Previews: PreviewProvider {
    static var previews: some View {
        axs()
    }
}
