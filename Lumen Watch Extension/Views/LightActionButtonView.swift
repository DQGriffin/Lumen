//
//  LightActionButtonView.swift
//  Lumen Watch Extension
//
//  Created by Dquavius Griffin on 11/7/20.
//

import SwiftUI

struct LightActionButtonView: View {
    let action: LightAction
    
    var body: some View {
        Button(action: {
            action.perform()
        }) {
            Text(action.description)
        }
    }
}

struct LightActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LightActionButtonView(action: LightAction(title: "Magic Light", description: "15%", red: 0, green: 0, blue: 255, action: previewTestFunction(action:)))
    }
    
    static func previewTestFunction(action: LightAction) {
    }
}
