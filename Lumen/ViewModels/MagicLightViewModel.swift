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
    @AppStorage("active-action-static-id") var activeActionStaticID = ""
    
    init() { 
        actions = [LightAction]()
        magicLightManager.delegate = self
        actions.append(LightAction(title: "Magic Light", description: "0%", white: 0, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "3%", white: 3, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "5%", white: 5, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "10%", white: 10, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "20%", white: 20, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "30%", white: 30, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "60%", white: 60, action: performAction(action:)))
        actions.append(LightAction(title: "Magic Light", description: "100%", white: 100, action: performAction(action:)))
        actions.append(LightAction(title: "Debug", description: "This is a very long description", action: performAction(action:)))
        print("Initializer | Active Action Static ID: \(activeActionStaticID)")
        //setActionActive(withID: activeActionID)
        setActionActive(withStaticID: activeActionStaticID)
    }
    
    func performAction(withID id: Int) {
        
        var selectedAction: LightAction?
        
        for action in actions {
            if action.id == id {
                selectedAction = action
                break
            }
        }
        
        if let safeAction = selectedAction {
            performAction(action: safeAction)
        }
    }
    
    func performAction(action: LightAction) {
        if action.isRGB {
            print("This is an RGB Light Action")
        }
        else {
            print("This is not an RGB Light Action")
            performWhiteAction(action: action)
        }
    }
    
    fileprivate func performRGBAction(action: LightAction) {
        
    }
    
    fileprivate func performWhiteAction(action: LightAction) {
        print("Value: \(action.white)")
        print("Adjusted Value: \(action.adjustedWhite)")
        let data = Data(bytes: [action.adjustedWhite], count: 1)
        magicLightManager.setBrightness(to: data)
        currentBrightnessValue = action.white
        clearActiveAction()
        setActionActive(withID: action.id)
        activeActionStaticID = action.staticIdentifier
    }
    
    func setBrightness(to targetBrightness: String) {
        let brightness = targetBrightness.replacingOccurrences(of: "%", with: "")
        let adjustedBrightness = getAdjustedBrightnessValue(from: Int.init(brightness)!)
        let data = Data(bytes: [adjustedBrightness], count: 1)
        magicLightManager.setBrightness(to: data)
        currentBrightnessValue = Int.init(brightness)!
        //setActionActive(withDescription: targetBrightness)
    }
    
    func setActionActive(withID id: Int) {
        for index in 0..<actions.count {
            if actions[index].id == id {
                actions[index].isActive = true
            }
            else {
                actions[index].isActive = false
            }
        }
        objectWillChange.send()
    }
    
    func setActionActive(withStaticID id: String) {
        for index in 0..<actions.count {
            if actions[index].staticIdentifier == id {
                actions[index].isActive = true
            }
            else {
                actions[index].isActive = false
            }
        }
        objectWillChange.send()
    }
    
    func clearActiveAction() {
        for index in 0..<actions.count {
            actions[index].isActive = false
        }
        objectWillChange.send()
    }
    
    fileprivate func getAdjustedBrightnessValue(from value: Int) -> Int {
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
