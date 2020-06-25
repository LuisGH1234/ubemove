import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDYGiwEMi6u7dvyWQKMZ4j7kyqJVq7h4zs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
