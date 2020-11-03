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
            HStack {
                Spacer()
                Text("Lumen")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Circle()
                    .frame(width: 15, height: 15, alignment: .center)
                    .padding(.trailing)
                    .foregroundColor((viewModel.connectionStatus == .connected) ? Color.green : Color.red)
                    .opacity(0.7)
            }
            
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(viewModel.actions) { action in
                    MagicLightButtonView(action: action)
                        .onTapGesture(count: 1, perform: {
                            action.perform()
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
