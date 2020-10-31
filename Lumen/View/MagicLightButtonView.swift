//
//  MagicLightButtonView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import SwiftUI

struct MagicLightButtonView: View {
    
    let title: String
    let description: String
    
    var body: some View {
        GroupBox(label: Label(title, systemImage:  "lightbulb.fill").foregroundColor(.blue)) {
            Text(description)
        }
        .groupBoxStyle(DefaultGroupBoxStyle())
    }
}

struct MagicLightButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MagicLightButtonView(title: "Pure White", description: "75%")
    }
}
