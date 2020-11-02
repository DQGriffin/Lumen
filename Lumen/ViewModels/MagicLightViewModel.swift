//
//  MagicLightViewModel.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import Foundation
import SwiftUI

class MagicLightViewModel: ObservableObject {
    var actions: [LightAction]
    let magicLightManager = MagicLightManager()
    var connectionStatus: ConnectionStatus = .disconnected
    @AppStorage("brightness") var currentBrightnessValue = 0
    
    init() { 
        actions = [LightAction]()
        magicLightManager.delegate = self
        actions.append(LightAction(title: "Magic Light", description: "0%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "3%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "5%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "10%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "20%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "30%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "60%", action: setBrightness))
        actions.append(LightAction(title: "Magic Light", description: "100%", action: setBrightness))
        setActionActive(withDescription: String("\(currentBrightnessValue)%"))
    }
    
    func setBrightness(to targetBrightness: String) {
        let brightness = targetBrightness.replacingOccurrences(of: "%", with: "")
        let adjustedBrightness = getAdjustedBrightnessValue(from: Int.init(brightness)!)
        let data = Data(bytes: [adjustedBrightness], count: 1)
        magicLightManager.setBrightness(to: data)
        currentBrightnessValue = Int.init(brightness)!
        setActionActive(withDescription: targetBrightness)
    }
    
    func setActionActive(withDescription description: String) {
        for index in 0..<actions.count {
            if actions[index].description == description {
                actions[index].isActive = true
            }
            else {
                actions[index].isActive = false
            }
            objectWillChange.send()
        }
    }
    
    func getAdjustedBrightnessValue(from value: Int) -> Int {
        var adjustedValue = value * 255
        adjustedValue = adjustedValue / 100
        return adjustedValue
    }
    
}

// MARK: - MagicLightManagerDelegate
extension MagicLightViewModel: MagicLightManagerDelegate {
    func magicLightManager(didChangeConnectionStatusTo status: ConnectionStatus) {
        connectionStatus = status
        objectWillChange.send()
    }
}
