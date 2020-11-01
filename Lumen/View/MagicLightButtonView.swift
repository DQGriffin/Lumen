//
//  MagicLightButtonView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import SwiftUI

struct MagicLightButtonView: View {
    let action: LightAction
    
    var body: some View {
        GroupBox(label: Label(action.title, systemImage:  "lightbulb.fill").foregroundColor(action.isActive ? .yellow : .blue)) {
            Text(action.description)
                .foregroundColor(action.isActive ? .yellow : .init(UIColor.label))
        }
        .groupBoxStyle(DefaultGroupBoxStyle())
    }
}

struct MagicLightButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MagicLightButtonView(action: LightAction(title: "MagicLight", description: "15%", action: { _ in
            print("Happy now, Xcode?")
        }))
    }
}
