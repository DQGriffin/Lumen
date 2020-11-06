//
//  LightActionEditorView.swift
//  Lumen
//
//  Created by Dquavius Griffin on 11/6/20.
//

import SwiftUI

struct LightActionEditorView: View {
    
    var action: LightAction
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Inspect")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {isPresented.toggle()}) {
                    Text("Done")
                        .foregroundColor(.blue)
                        .padding()
                }
                .cornerRadius(4)
                .border(Color.blue, width: 2)
            }
            .padding()
            VStack {
                HStack {
                    Text("Title: ")
                        .font(.title)
                    Spacer()
                    Text(action.title)
                }
                .padding(.horizontal)
                HStack {
                    Text("Description: ")
                        .font(.title)
                    Spacer()
                    Text(action.description)
                }
                .padding(.horizontal)
                HStack {
                    Text("Red: ")
                        .font(.title)
                    Spacer()
                    Text("\(action.r)")
                }
                .padding(.horizontal)
                HStack {
                    Text("Green: ")
                        .font(.title)
                    Spacer()
                    Text("\(action.g)")
                }
                .padding(.horizontal)
                HStack {
                    Text("Blue: ")
                        .font(.title)
                    Spacer()
                    Text("\(action.b)")
                }
                .padding(.horizontal)
                HStack {
                    Text("White: ")
                        .font(.title)
                    Spacer()
                    Text("\(action.white)")
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}


struct LightActionEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let action = LightAction(title: "Magic Light", description: "RGB Blue", red: 0, green: 0, blue: 255, action: previewTestFunction(action:))
        LightActionEditorView(action: action, isPresented: .constant(false))
        //        LightActionEditorView(action: nil)
    }
    
    static func previewTestFunction(action: LightAction) {
    }
}
