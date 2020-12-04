import Flutter
import UIKit
import Braintree
import BraintreeDropIn

public class SwiftBraintreeModulePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "braintree_module", binaryMessenger: registrar.messenger())
    let instance = SwiftBraintreeModulePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "init" {
        guard let args = call.arguments as? [String: Any] else {
          result("iOS could not recognize flutter arguments in method: (init)")
          return
        }
        let paymentToken : String = args["paymentToken"] as! String
        showDropIn(clientTokenOrTokenizationKey: paymentToken, result: result)
    }
  }

    func showDropIn(clientTokenOrTokenizationKey: String, result: @escaping FlutterResult) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, paymentResult, error) in
            if (error != nil) {
                print(error!)
            } else if (paymentResult?.isCancelled == true) {
                print("CANCELLED")
            } else if let paymentResult = paymentResult {
                let nonce: String = paymentResult.paymentMethod!.nonce
                result(nonce)
                return
            }
            controller.dismiss(animated: true, completion: nil)
            result(nil)
            return
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(dropIn!, animated: true, completion: nil)
    }
}
