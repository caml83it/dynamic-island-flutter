import Foundation
import ActivityKit

@available(iOS 16.1, *)
class WidgetManager {
  static let shared = WidgetManager()
  private init() {}
  
  private var channel: FlutterMethodChannel?
  private let channelName: String = "com.mica.app-name/widget"
  
  private var activity: Activity<MatchAttributes>?
  
  func register(with messenger: FlutterBinaryMessenger) -> Void {
    print(#function)
    channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    channel!.setMethodCallHandler(handler(call:result:))
  }
  
  enum WidgetMethod: String {
    case startLiveActivities = "startLiveActivities"
    case updateLiveActivities = "updateLiveActivities"
    case stopLiveActivities = "stopLiveActivities"
  }
  
  func handler(call: FlutterMethodCall, result: FlutterResult) {
    switch(call.method) {
    case WidgetMethod.startLiveActivities.rawValue:
      self.startLiveActivities()
    case WidgetMethod.stopLiveActivities.rawValue:
      self.stopLiveActivities()
    case WidgetMethod.updateLiveActivities.rawValue:
      if let args = call.arguments as? Dictionary<String, Any> {
        if let hScrore = args["hScore"] as? Int, let aScrore = args["aScore"] as? Int {
          self.updateLiveActivities(hScrore, aScrore)
        }
      }
    default:
      break
    }
  }
  
  func startLiveActivities() {
    print(#function)
    let initialContentState = MatchAttributes.ContentState(homeScore: 0, awayScore: 0)
    let initialAttributes = MatchAttributes(homeName: "MU", awayName: "MC")
    
    do {
      activity = try Activity.request(attributes: initialAttributes, contentState: initialContentState)
    } catch (let error) {
      print(error.localizedDescription)
    }
  }
  
  func updateLiveActivities(_ hScore: Int, _ aScrore: Int) {
    print(#function)
    let updateContentState = MatchAttributes.ContentState(homeScore: hScore, awayScore: aScrore)
    let alertConfiguration = AlertConfiguration(
      title: "Update Score",
      body: "Goalllllll......",
      sound: .default)
    Task {
      await activity?.update(using: updateContentState, alertConfiguration: alertConfiguration)
    }
  }
  
  func stopLiveActivities() {
    print(#function)
    Task {
      await activity?.end(using: activity?.contentState, dismissalPolicy: .immediate)
    }
  }
}
