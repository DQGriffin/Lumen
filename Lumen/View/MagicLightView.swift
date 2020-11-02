//
//  MagicLightView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import SwiftUI

struct MagicLightView: View {
    
    @StateObject var viewModel = MagicLightViewModel()
    
    var body: some View {
        ScrollView {
            Text("Lumen")
                .font(.title)
                .fontWeight(.bold)
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(viewModel.actions) {action in
                    MagicLightButtonView(action: action)
                        .onTapGesture(count: 1, perform: {
                            action.action(action.description)
                        })
                }
            }
        }
        .padding()
    }
}

struct MagicLightView_Previews: PreviewProvider {
    static var previews: some View {
        MagicLightView()
    }
}
