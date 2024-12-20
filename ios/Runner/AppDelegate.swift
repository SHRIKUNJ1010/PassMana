import UIKit
import Flutter
import LocalAuthentication

@main
@objc class AppDelegate: FlutterAppDelegate {

  //method channel name
  let biometricsChannelName = "com.passmana.app/biometrics"

  //calling method name
  let verifyBiometricMethodName = "verifyBiometric"

  //method channel variable
  var biometricsChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //get the root controller for the flutter view
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    // Initialize the method channel once the flutter engines is attached
    biometricsChannel = FlutterMethodChannel(name: biometricsChannelName, binaryMessenger: controller.binaryMessenger)

    //Set a method call handler
    biometricsChannel?.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        //This method is invoked on the UI thread , Handle calls to biometrics channel
        guard call.method == self.verifyBiometricMethodName else {
            result(false)
            return
        }
        self.authenticationWithBiometrics(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func authenticationWithBiometrics(result: @escaping FlutterResult) -> Void {
    let context = LAContext()

    if #available(iOS 10.0, *) {
        context.localizedCancelTitle = "Use Password"
    }

    var error: NSError?

    // Check for biometric authentication permissions
    let permissions = context.canEvaluatePolicy(
        .deviceOwnerAuthentication,
        error: &error
    )

    if permissions {
        let reason = "Log in with Face ID"
        context.evaluatePolicy(
            //.deviceOwnerAuthentication allows biometric or passcode authentication
            .deviceOwnerAuthentication,
            localizedReason: reason
        ) { success, error in
            // Send the authentication result to Flutter, either true or false
            result(true)
        }
    } else {
        result(false)
    }

    return
  }
}
