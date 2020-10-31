//
//  LightAction.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import Foundation

struct LightAction: Identifiable {
    var id: Int
    let title: String
    let description: String
    let action: (String) -> Void
    var isActive = false
    
    init(title: String, description: String, action: @escaping (String) -> Void) {
        self.title = title
        self.description = description
        self.action = action
        id = Int.random(in: 0..<10000)
    }
}
