//
//  BLEScan.swift
//  BLEScan
//
//  Created by mac on 21/03/2022.
//

import Foundation
import Bluejay
let bluejay = Bluejay()

bluejay.start()

public protocol ConnectionObserver: class {
    func bluetoothAvailable(_ available: Bool)
    func connected(to peripheral: PeripheralIdentifier)
    func disconnected(from peripheral: PeripheralIdentifier)
}
bluejay.scan(
    serviceIdentifiers: [heartRateService],
    discovery: { [weak self] (discovery, discoveries) -> ScanAction in
        guard let weakSelf = self else {
            return .stop
        }

        weakSelf.discoveries = discoveries
        weakSelf.tableView.reloadData()

        return .continue
    },
    stopped: { (discoveries, error) in
        if let error = error {
            debugPrint("Scan stopped with error: \(error.localizedDescription)")
        }
        else {
            debugPrint("Scan stopped without error.")
        }
})
bluejay.connect(selectedSensor, timeout: .seconds(15)) { result in
    switch result {
    case .success:
        debugPrint("Connection attempt to: \(selectedSensor.description) is successful")
    case .failure(let error):
        debugPrint("Failed to connect with error: \(error.localizedDescription)")
    }
}
public enum Timeout {
    case seconds(TimeInterval)
    case none
}
