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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WatchMainView_Previews: PreviewProvider {
    static var previews: some View {
        WatchMainView()
    }
}
