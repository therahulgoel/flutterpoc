import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    handleFlutterToNativeChannelsCommunication()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func handleFlutterToNativeChannelsCommunication(){
        let channelName = "sendData"
        let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController.binaryMessenger)
        methodChannel.setMethodCallHandler { (call:FlutterMethodCall, result:FlutterResult) in
            if call.method == "start"{
                self.start(call.arguments as? String)
            }
        }
        sendDataFromNativeToFlutter()
        
    }
    
    //native start method
    func start(_ arg:String?){
        if let arg = arg{
            print("Data passed from flutter to iOS : \(arg) ")
        }else{
            print("No data passed from flutter just a handshake from flutter to iOS")
        }
    }
    
    @objc func sendDataFromNativeToFlutter(){
        let channelName = "iOSToFlutter"
        let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController.binaryMessenger)
        channel.invokeMethod("receiveDataFromNative", arguments: "Hi from iOS")
    }
    
    
}
