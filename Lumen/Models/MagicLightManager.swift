//
//  MagicLightManager.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/29/20.
//

import Foundation
import CoreBluetooth

class MagicLightManager: NSObject {
    let centralManager = CBCentralManager()
    let targetServiceUUID = CBUUID(string: "0x1804")
    var scanningForPeripheralByName = false
    var targetPeripheralName = ""
    
    var peripheral: CBPeripheral!
    var characteristics: [CBCharacteristic] = []
    var brightnessCharacteristic: CBCharacteristic?
    var delegate: MagicLightManagerDelegate?
    
    override init() {
        super.init()
        centralManager.delegate = self
        targetPeripheralName = "LEDBlue-DCDA6D2E"
        scanForPeripheral(withName: targetPeripheralName)
    }
    
    func scanForPeripheral(withName name: String) {
        scanningForPeripheralByName = true
    }
    
    fileprivate func getcharacteristicNames() {
        for characteristic in characteristics {
            print("UUID: \(characteristic.uuid)")
        }
    }
    
}

extension MagicLightManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Bluetooth state: Unknown")
        case .resetting:
            print("Bluetooth state: Resetting")
        case .unsupported:
            print("Bluetooth state: Unsupported")
        case .unauthorized:
            print("Bluetooth state: Unauthorized")
        case .poweredOff:
            print("Bluetooth state: Powered off")
        case .poweredOn:
            print("Bluetooth state: Powered on")
            centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("Bluetooth state: Unknown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if scanningForPeripheralByName && peripheral.name == targetPeripheralName {
            central.stopScan()
            central.connect(peripheral)
            self.peripheral = peripheral
            peripheral.delegate = self
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.magicLightManager(didChangeConnectionStatusTo: .connected)
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral.name == targetPeripheralName {
            delegate?.magicLightManager(didChangeConnectionStatusTo: .disconnected)
        }
    }
    
}

extension MagicLightManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let serviceCharacteristics = service.characteristics {
            characteristics.append(contentsOf: serviceCharacteristics)
            storeBrightnessCharacteristic()
        }
    }
    
    func storeBrightnessCharacteristic() {
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "FFEA") {
                brightnessCharacteristic = characteristic
            }
        }
    }
    
    func setBrightness(to brightness: Data) {
        if let safeBrightnessCharacteristic = brightnessCharacteristic {
            peripheral.writeValue(brightness, for: safeBrightnessCharacteristic, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
    func printCharacteristics() {
        print("Characteristics -------------------------------------")
        for characteristic in characteristics {
            print(characteristic)
        }
    }
}

// MARK: - MagicLightManagerDelegate
protocol MagicLightManagerDelegate {
    func magicLightManager(didChangeConnectionStatusTo status: ConnectionStatus)
}

enum ConnectionStatus {
    case connected
    case disconnected
}
