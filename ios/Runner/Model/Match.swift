import Foundation
import ActivityKit

struct MatchAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    var homeScore: Int
    var awayScore: Int
  }
  
  var homeName: String
  var awayName: String
}
