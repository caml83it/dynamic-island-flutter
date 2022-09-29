import 'package:flutter/services.dart';

class LiveActivities {
  LiveActivities._();

  static final _instance = LiveActivities._();

  static get instance => _instance;

  static const _channel = MethodChannel("com.mica.app-name/widget");

  void startLiveActivity() {
    _channel.invokeMethod("startLiveActivities");
  }

  void stopLiveActivity() {
    _channel.invokeMethod("stopLiveActivities");
  }

  void updateLiveActivity({required int homeScore, required int awayScore}) {
    _channel.invokeMethod("updateLiveActivities", {
      "hScore": homeScore,
      "aScore": awayScore,
    });
  }
}
