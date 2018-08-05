import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/main.dart';

void notificationMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is SendAchievementNotificationAction) {
    new Future.delayed(new Duration(seconds: 1), () {}).then(
      (result) {
        if (store.state.achievedAchievements[ACHIEVED].isNotEmpty) {
          if (store.state.achievedAchievements[ACHIEVED].length > 1) {
            showAchievementNotification(
                "Sehr gut! Du hast ${store.state
                    .achievedAchievements[ACHIEVED]
                    .length} Achievement erhalten",
                "");
          } else if (store.state.achievedAchievements[ACHIEVED].length == 1) {
            showAchievementNotification(
                "Sehr gut! Du hast ein Achievement erhalten",
                store.state.achievedAchievements[ACHIEVED].values
                    .toList()[0]
                    .title);
          }
        }
        action.completer.complete();
        store.dispatch(new ClearAchievedAction());
      },
    );
  }
  next(action);
}
