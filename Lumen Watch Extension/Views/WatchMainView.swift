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
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .padding(.trailing)
                .foregroundColor((viewModel.connectionStatus == .connected) ? Color.green : Color.blue)
                .opacity(0.7)
            Button(action: {viewModel.attemptToConnect()}) {
                Text("Connect")
            }
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
