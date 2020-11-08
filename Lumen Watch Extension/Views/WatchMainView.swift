//
//  WatchMainView.swift
//  Lumen Watch Extension
//
//  Created by Dquavius Griffin on 11/7/20.
//

import SwiftUI

struct WatchMainView: View {
    
    @StateObject var viewModel = MagicLightViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(viewModel.actions) { action in
                    LightActionButtonView(action: action)
                }
            }
        }
    }
}

struct WatchMainView_Previews: PreviewProvider {
    static var previews: some View {
        WatchMainView()
    }
}
