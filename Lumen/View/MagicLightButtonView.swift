//
//  MagicLightButtonView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import SwiftUI

struct MagicLightButtonView: View {
    let action: LightAction
    @State var isPresentingEditor = false
    
    var body: some View {
        GroupBox(label: Label(action.title, systemImage:  "lightbulb.fill").foregroundColor(.blue)) {
            Text(action.description)
        }
        .groupBoxStyle(DefaultGroupBoxStyle())
        .contextMenu {
            Button(action: {
                self.isPresentingEditor.toggle()
            }) {
                Label("Inspect", systemImage: "magnifyingglass")
            }
        }
        .overlay(action.isRGB ? ButtonViewOverlay(color: action.rgbColor, opacity: 0.004) : nil)
        .overlay(action.isActive ? ButtonViewOverlay(color: .blue, opacity: 0.2) : nil)
        .animation(.easeInOut(duration: 0.1))
        .sheet(isPresented: $isPresentingEditor) {
            LightActionEditorView(action: action, isPresented: $isPresentingEditor)
        }
    }
}

struct ButtonViewOverlay: View {
    
    let color: Color
    let opacity: Double
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .opacity(opacity)
            .cornerRadius(5.0)
    }
}

struct MagicLightButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MagicLightButtonView(action: LightAction(title: "Magic Light", description: "15%"))
    }
}
