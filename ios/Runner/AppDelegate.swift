import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var beaconPlusHandler: BeaconPlusHandler?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     GMSServices.provideAPIKey("AIzaSyAnWuXzxjMbe_hReDm5QEohp6P6b0q6jJ4")
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup BeaconPlus platform channel
    setupBeaconPlusChannel()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func setupBeaconPlusChannel() {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      print("❌ Failed to get FlutterViewController")
      return
    }
    
    beaconPlusHandler = BeaconPlusHandler()
    
    // Method channel for commands
    let methodChannel = FlutterMethodChannel(
      name: "com.luggage_tracking/beacon_plus",
      binaryMessenger: controller.binaryMessenger
    )
    
    methodChannel.setMethodCallHandler { [weak self] (call, result) in
      self?.handleMethodCall(call, result: result)
    }
    
    // Event channel for streaming data
    let eventChannel = FlutterEventChannel(
      name: "com.luggage_tracking/beacon_plus_events",
      binaryMessenger: controller.binaryMessenger
    )
    
    eventChannel.setStreamHandler(beaconPlusHandler)
    
    print("✅ BeaconPlus platform channel setup complete")
  }
  
  private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let handler = beaconPlusHandler else {
      result(FlutterError(code: "UNAVAILABLE", message: "BeaconPlus handler not initialized", details: nil))
      return
    }
    
    switch call.method {
    case "startScan":
      handler.startScan()
      result(nil)
      
    case "stopScan":
      handler.stopScan()
      result(nil)
      
    case "connectToDevice":
      guard let args = call.arguments as? [String: Any],
            let macAddress = args["macAddress"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "MAC address required", details: nil))
        return
      }
      let password = args["password"] as? String
      handler.connectToDevice(macAddress: macAddress, password: password)
      result(nil)
      
    case "disconnectDevice":
      handler.disconnectDevice()
      result(nil)
      
    case "getDeviceInfo":
      handler.getDeviceInfo()
      result(nil)
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
