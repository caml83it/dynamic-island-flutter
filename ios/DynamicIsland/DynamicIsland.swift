import WidgetKit
import SwiftUI

@main
struct DynamicIslandWidget: Widget {
  let kind: String = "DynamicIsland"
  
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: MatchAttributes.self) { context in
      // View thats appear on the Lock Screen
      LockScreenLiveActivityView(context: context)
    } dynamicIsland: { context in
      DynamicIsland {
        // Create the expanded view.
        DynamicIslandExpandedRegion(.leading) {
          VStack {
            Text(context.attributes.homeName)
              .font(.body)
            
            Text("\(context.state.homeScore)")
              .font(.headline)
          }
        }
        
        DynamicIslandExpandedRegion(.trailing) {
          VStack {
            Text(context.attributes.awayName)
              .font(.body)
            
            Text("\(context.state.awayScore)")
              .font(.headline)
          }
        }
      } compactLeading: {
        VStack {
          Text(context.attributes.homeName)
            .font(.body)
          
          Text("\(context.state.homeScore)")
            .font(.headline)
        }
        .padding(.all, 4)
      } compactTrailing: {
        VStack {
          Text(context.attributes.awayName)
            .font(.body)
          
          Text("\(context.state.awayScore)")
            .font(.headline)
        }
        .padding(.all, 4)
      } minimal: {
        VStack {
          Image(systemName: "gamecontroller")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(.white)
        }
      }
    }
  }
}

struct LockScreenLiveActivityView: View {
  let context: ActivityViewContext<MatchAttributes>
  
  var body: some View {
    HStack {
      VStack {
        Text(context.attributes.homeName)
          .font(.system(size: 18))
          .fontWeight(.regular)
          .foregroundColor(.black)
        
        Text("\(context.state.homeScore)")
          .font(.system(size: 32))
          .fontWeight(.semibold)
          .foregroundColor(.black)
      }
      
      Spacer()
      
      VStack {
        Text(context.attributes.awayName)
          .font(.system(size: 18))
          .fontWeight(.regular)
          .foregroundColor(.black)
        
        Text("\(context.state.awayScore)")
          .font(.system(size: 32))
          .fontWeight(.semibold)
          .foregroundColor(.black)
      }
    }
    .padding(.horizontal, 20)
    .activitySystemActionForegroundColor(.indigo)
    .activityBackgroundTint(.cyan)
  }
}
