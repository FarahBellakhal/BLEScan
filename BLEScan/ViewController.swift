//
//  ViewController.swift
//  BLEScan
//
//  Created by mac on 21/03/2022.
//


// Peripherals are devices that are scanned for, central scans for devices.
// Peripherals are identified by UUID (universally unique ID)
import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    // centralManagerDidUpdateState tells it its updated
    // CBManagerState is the state of Core Bluetooth Manager
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
            print ("Scanning...")
        }
    }
    
    // centralManager tells it its discovered a peripheral while scanning
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print (peripheral.name ?? "no name")
    }
    
    
    //CBCentralManager scans and manages discovered/connected remote devices
    var centralManager : CBCentralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        centralManager = CBCentralManager.init(delegate: self, queue: nil)
    }


}

