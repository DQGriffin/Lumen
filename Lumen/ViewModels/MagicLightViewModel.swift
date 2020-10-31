//
//  MagicLightViewModel.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import Foundation

class MagicLightViewModel {
    var actions: [LightAction]
    let magicLightManager = MagicLightManager()
    
    let hexMap = ["0": 0x0, "3": 0x8, "10": 0x19, "30": 0x4D, "60": 0x99, "100": 0xFF]
    
    init() { 
        actions = [LightAction]()
        actions.append(LightAction(title: "Magic Light", description: "0%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "3%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "10%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "30%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "60%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "100%", action: setBrightness))
    }
    
    func setBrightness(to targetBrightness: String) {
        print("Setting brightness to \(targetBrightness)")
        let brightness = targetBrightness.replacingOccurrences(of: "%", with: "")
        print("Extracted: \(brightness)")
        let data = Data(bytes: [getAdjustedBrightnessValue(from: Int.init(brightness)!)], count: 1)
        magicLightManager.setBrightness(to: data)
    }
    
    func getAdjustedBrightnessValue(from value: Int) -> Int {
        var adjustedValue = value * 255
        adjustedValue = adjustedValue / 100
        return adjustedValue
    }
    
}
