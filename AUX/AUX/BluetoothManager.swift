//
//  CoreBluetoothManager.swift
//  AUX
//
//  Created by Sean Nguyen on 2020-10-23.
//
import UIKit
import CoreBluetooth

enum Constants: String {
    case SERVICE_UUID = "4DF91029-B356-463E-9F48-BAB077BF3EF5"
}

protocol BluetoothManagerDelegate: AnyObject {
    func peripheralsDidUpdate()
}

protocol BluetoothManager {
    var peripherals: Dictionary<UUID, CBPeripheral> { get }
    var delegate: BluetoothManagerDelegate? { get set }
    func startAdvertising(with name: String)
    func startScanning()
}

extension CoreBluetoothManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            if peripheral.isAdvertising {
                print("stop advertising");
                peripheral.stopAdvertising()
            }

            let uuid = CBUUID(string: Constants.SERVICE_UUID.rawValue)
            var advertisingData: [String : Any] = [
                CBAdvertisementDataServiceUUIDsKey: [uuid]
            ]

            if let name = self.name {
                print("advertise");
                advertisingData[CBAdvertisementDataLocalNameKey] = name
            }
            self.peripheralManager?.startAdvertising(advertisingData)
        } else {
            print("other state");
        }
    }
}

extension CoreBluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {

            if central.isScanning {
                print("stop scan");
                central.stopScan()
            }
            print("scan");
            let uuid = CBUUID(string: Constants.SERVICE_UUID.rawValue)
            central.scanForPeripherals(withServices: [uuid])
        } else {
            print("other state");
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        peripherals[peripheral.identifier] = peripheral
    }
}

class CoreBluetoothManager: NSObject, BluetoothManager {
    // MARK: - Public properties
    weak var delegate: BluetoothManagerDelegate?
    private(set) var peripherals = Dictionary<UUID, CBPeripheral>() {
        didSet {
            delegate?.peripheralsDidUpdate()
        }
    }

    // MARK: - Public methods
    func startAdvertising(with name: String) {
        self.name = name
        if peripheralManager == nil {
            peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        }
    }

    func startScanning() {
        if centralManager == nil {
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
    }

    // MARK: - Private properties
    private var peripheralManager: CBPeripheralManager?
    private var centralManager: CBCentralManager?
    private var name: String?
}


