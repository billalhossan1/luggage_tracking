import Flutter
import UIKit
import MTBeaconPlus

class BeaconPlusHandler: NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    private var centralManager: MTCentralManager?
    private var connectedPeripheral: MTPeripheral?
    private var scanTimer: Timer?
    private var rssiTimer: Timer?
    private var discoveredDevices: [String: MTPeripheral] = [:]
    
    // MARK: - Initialization
    override init() {
        super.init()
        centralManager = MTCentralManager.sharedInstance()
        setupBluetoothStateListener()
    }
    
    // MARK: - Bluetooth State Listener
    private func setupBluetoothStateListener() {
        centralManager?.stateBlock = { [weak self] state in
            self?.sendEvent([
                "type": "bluetoothState",
                "state": self?.powerStateToString(state) ?? "unknown"
            ])
        }
    }
    
    private func powerStateToString(_ state: PowerState) -> String {
        switch state {
        case .poweredOn:
            return "poweredOn"
        case .poweredOff:
            return "poweredOff"
        case .unauthorized:
            return "unauthorized"
        case .unsupported:
            return "unsupported"
        case .resetting:
            return "resetting"
        default:
            return "unknown"
        }
    }
    
    // MARK: - Scan Methods
    func startScan() {
        print("🔍 Starting BeaconPlus scan...")
        discoveredDevices.removeAll()
        
        centralManager?.startScan { [weak self] peripherals in
            guard let self = self, let peripherals = peripherals else { return }
            
            var devicesData: [[String: Any]] = []
            
            for peripheral in peripherals {
                guard let framer = peripheral.framer else { continue }
                
                // Store discovered device
                if let mac = framer.mac {
                    self.discoveredDevices[mac] = peripheral
                }
                
                var deviceData: [String: Any] = [
                    "name": framer.name ?? "Unknown",
                    "rssi": framer.rssi,
                    "mac": framer.mac ?? "",
                ]
                
                // Add battery if available
                if framer.battery != MTNAValue {
                    deviceData["battery"] = framer.battery
                }
                
                // Parse advertisement frames
                if let frames = framer.advFrames {
                    var framesData: [[String: Any]] = []
                    
                    for frame in frames {
                        var frameData: [String: Any] = [
                            "frameType": self.frameTypeToString(frame.frameType)
                        ]
                        
                        // Parse specific frame types
                        if let iBeacon = frame as? MinewiBeacon {
                            frameData["uuid"] = iBeacon.uuid
                            frameData["major"] = iBeacon.major
                            frameData["minor"] = iBeacon.minor
                            frameData["slotNumber"] = iBeacon.slotNumber
                            frameData["slotAdvInterval"] = iBeacon.slotAdvInterval
                            frameData["slotAdvTxpower"] = iBeacon.slotAdvTxpower
                            frameData["slotRadioTxpower"] = iBeacon.slotRadioTxpower
                        } else if let uid = frame as? MinewUID {
                            frameData["namespaceId"] = uid.namespaceId
                            frameData["instanceId"] = uid.instanceId
                            frameData["txPower"] = uid.txPower
                        } else if let url = frame as? MinewURL {
                            frameData["url"] = url.urlString
                            frameData["txPower"] = url.txPower
                        } else if let deviceInfo = frame as? MinewDeviceInfo {
                            frameData["battery"] = deviceInfo.battery
                            frameData["mac"] = deviceInfo.mac
                            frameData["name"] = deviceInfo.name
                        }
                        
                        framesData.append(frameData)
                    }
                    
                    deviceData["frames"] = framesData
                }
                
                devicesData.append(deviceData)
            }
            
            self.sendEvent([
                "type": "scanResult",
                "devices": devicesData
            ])
        }
    }
    
    func stopScan() {
        print("🛑 Stopping BeaconPlus scan...")
        centralManager?.stopScan()
        scanTimer?.invalidate()
        scanTimer = nil
    }
    
    private func frameTypeToString(_ frameType: FrameType) -> String {
        switch frameType {
        case .iBeacon:
            return "iBeacon"
        case .UID:
            return "UID"
        case .URL:
            return "URL"
        case .TLM:
            return "TLM"
        case .DeviceInfo:
            return "DeviceInfo"
        case .HTSensor:
            return "HTSensor"
        case .LineBeacon:
            return "LineBeacon"
        default:
            return "Unknown"
        }
    }
    
    // MARK: - Connection Methods
    func connectToDevice(macAddress: String, password: String?) {
        print("🔗 Connecting to device: \(macAddress)")
        
        guard let peripheral = discoveredDevices[macAddress] else {
            sendEvent([
                "type": "connectionError",
                "error": "Device not found in discovered devices"
            ])
            return
        }
        
        // Setup connection status handler
        peripheral.connector?.statusChangeHandler = { [weak self] status, error in
            self?.handleConnectionStatus(status, error: error)
        }
        
        // Connect to the device
        centralManager?.connect(to: peripheral, passwordRequire: { [weak self] passwordBlock in
            // Provide password if required
            let pwd = password ?? "minew123" // Default password
            passwordBlock?(pwd)
            
            self?.sendEvent([
                "type": "passwordRequired",
                "message": "Password validation in progress"
            ])
        })
        
        connectedPeripheral = peripheral
    }
    
    private func handleConnectionStatus(_ status: ConnectionStatus, error: Error?) {
        print("📡 Connection status: \(status.rawValue)")
        
        if let error = error {
            sendEvent([
                "type": "connectionError",
                "error": error.localizedDescription
            ])
            return
        }
        
        switch status {
        case .completed:
            sendEvent([
                "type": "connected",
                "message": "Device connected successfully"
            ])
            startRssiMonitoring()
            
        case .disconnected:
            sendEvent([
                "type": "disconnected",
                "message": "Device disconnected"
            ])
            stopRssiMonitoring()
            
        case .connectFailed:
            sendEvent([
                "type": "connectionError",
                "error": "Connection failed"
            ])
            
        default:
            sendEvent([
                "type": "connectionStatus",
                "status": connectionStatusToString(status)
            ])
        }
    }
    
    private func connectionStatusToString(_ status: ConnectionStatus) -> String {
        switch status {
        case .connecting:
            return "connecting"
        case .connected:
            return "connected"
        case .readingInfo:
            return "readingInfo"
        case .deviceValidating:
            return "deviceValidating"
        case .passwordValidating:
            return "passwordValidating"
        case .sycingTime:
            return "syncingTime"
        case .completed:
            return "completed"
        case .disconnected:
            return "disconnected"
        case .connectFailed:
            return "connectFailed"
        default:
            return "undefined"
        }
    }
    
    func disconnectDevice() {
        print("🔌 Disconnecting device...")
        
        if let peripheral = connectedPeripheral {
            centralManager?.disconnect(from: peripheral)
        }
        
        stopRssiMonitoring()
        connectedPeripheral = nil
    }
    
    // MARK: - RSSI Monitoring
    private func startRssiMonitoring() {
        print("📡 Starting RSSI monitoring...")
        
        // Monitor RSSI every 1.5 seconds
        rssiTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            self?.readRssi()
        }
    }
    
    private func stopRssiMonitoring() {
        print("🛑 Stopping RSSI monitoring...")
        rssiTimer?.invalidate()
        rssiTimer = nil
    }
    
    private func readRssi() {
        guard let peripheral = connectedPeripheral,
              let framer = peripheral.framer else {
            return
        }
        
        let rssi = framer.rssi
        let distance = calculateDistance(rssi: rssi)
        
        sendEvent([
            "type": "rssiUpdate",
            "rssi": rssi,
            "distance": distance,
            "mac": framer.mac ?? "",
            "name": framer.name ?? "Unknown"
        ])
    }
    
    private func calculateDistance(rssi: Int, txPower: Int = -59) -> Double {
        if rssi == 0 {
            return -1.0
        }
        
        let ratio = Double(txPower - rssi) / 20.0
        let distance = pow(10.0, ratio)
        
        return round(distance * 100) / 100
    }
    
    // MARK: - Device Information
    func getDeviceInfo() {
        guard let peripheral = connectedPeripheral,
              let connector = peripheral.connector else {
            sendEvent([
                "type": "error",
                "error": "No device connected"
            ])
            return
        }
        
        var deviceInfo: [String: Any] = [:]
        
        if let mac = connector.macString {
            deviceInfo["mac"] = mac
        }
        
        if let infoDict = connector.infoDict {
            deviceInfo["info"] = infoDict
        }
        
        deviceInfo["connectable"] = connectableToString(connector.connectable)
        deviceInfo["version"] = versionToString(connector.version)
        deviceInfo["passwordStatus"] = passwordStatusToString(connector.passwordStatus)
        
        if let feature = connector.feature {
            deviceInfo["slotCount"] = feature.slotAtitude
            deviceInfo["supportedFrames"] = feature.supportedSlots?.map { frameTypeToString(FrameType(rawValue: $0.intValue) ?? .none) }
            deviceInfo["supportedTxPowers"] = feature.supportedTxpowers
        }
        
        sendEvent([
            "type": "deviceInfo",
            "data": deviceInfo
        ])
    }
    
    private func connectableToString(_ connectable: Connectable) -> String {
        switch connectable {
        case .yes:
            return "yes"
        case .no:
            return "no"
        default:
            return "none"
        }
    }
    
    private func versionToString(_ version: Version) -> String {
        switch version {
        case .base:
            return "base"
        case .version0_9_8:
            return "0.9.8"
        case .version0_9_9:
            return "0.9.9"
        case .version2_0_0:
            return "2.0.0"
        case .version2_2_60:
            return "2.2.60"
        case .max:
            return "max"
        default:
            return "undefined"
        }
    }
    
    private func passwordStatusToString(_ status: PasswordStatus) -> String {
        switch status {
        case .require:
            return "required"
        case .none:
            return "none"
        default:
            return "unknown"
        }
    }
    
    // MARK: - FlutterStreamHandler
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    
    private func sendEvent(_ data: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.eventSink?(data)
        }
    }
}
