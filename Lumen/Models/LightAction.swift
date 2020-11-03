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
    var action: ((LightAction) -> Void)?
    var isActive = false
    var r: Int
    var g: Int
    var b: Int
    var white: Int
    
    var adjustedRed: Int {
        return getAdjustedValue(from: r)
    }
    
    var adjustedGreen: Int {
        return getAdjustedValue(from: g)
    }
    
    var adjustedBlue: Int {
        return getAdjustedValue(from: b)
    }
    
    var adjustedWhite: Int {
        return getAdjustedValue(from: white)
    }
    
    var isRGB: Bool {
        let result = (r == 0) && (g == 0) && (b == 0)
        return !result
    }
    
    var staticIdentifier: String {
        return "\(title)\(description)\(r)\(g)\(b)\(white)"
    }
    
    //------------------TEST--------------------
    init (title: String, description: String, action: @escaping (LightAction) -> Void) {
        self.title = title
        self.description = description
        self.action = action
        self.r = 0
        self.g = 0
        self.b = 0
        self.white = 0
        id = Int.random(in: 0..<10000)
    }
    //------------------TEST--------------------
    init(title: String, description: String) {
        self.title = title
        self.description = description
        self.action = nil
        self.r = 0
        self.g = 0
        self.b = 0
        self.white = 0
        id = Int.random(in: 0..<10000)
    }
    
    init(title: String, description: String, white: Int, action: @escaping (LightAction) -> Void) {
        self.title = title
        self.description = description
        self.action = action
        self.r = 0
        self.g = 0
        self.b = 0
        self.white = white
        id = Int.random(in: 0..<10000)
    }
    
    init(title: String, description: String, red: Int, green: Int, blue: Int, action: @escaping (LightAction) -> Void) {
        self.title = title
        self.description = description
        self.action = action
        self.r = red
        self.g = green
        self.b = blue
        self.white = 0
        id = Int.random(in: 0..<10000)
    }
    
    func perform() {
        if let safeAction = action {
            safeAction(self)
        }
    }
    
    fileprivate func getAdjustedValue(from value: Int) -> Int {
        var adjustedValue = value * 255
        adjustedValue = adjustedValue / 100
        return adjustedValue
    }
}
