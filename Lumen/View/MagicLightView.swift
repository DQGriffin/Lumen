//
//  MagicLightView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import SwiftUI

struct MagicLightView: View {
    
    let viewModel = MagicLightViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(viewModel.actions) {action in
                    MagicLightButtonView(title: action.title, description: action.description)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
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