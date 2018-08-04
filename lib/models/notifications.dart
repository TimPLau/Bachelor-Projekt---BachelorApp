import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/appstate.dart';

Future onSelectAchievementNotification(String payload, BuildContext context) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }

  Navigator.pushNamed(context, "/achievementOverview");
}

Future<dynamic> checkAchievementNotification(context) {
  StoreProvider.of<AppState>(context).dispatch(new CheckForAchieveAction(
      StoreProvider
          .of<AppState>(context)
          .state
          .achievedAchievements["AllAchievements"]));

  final action = new SendAchievementNotificationAction();
  StoreProvider.of<AppState>(context).dispatch(action);
  return action.completer.future;
}

Future showAchievementNotification(
    String achievementName, String achievementDescription) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, achievementName, achievementDescription, platformChannelSpecifics,
      payload: 'item x');
}
