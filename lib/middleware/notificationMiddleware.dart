import 'dart:async';
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
        if (store.state.achievedAchievements["Achieved"].isNotEmpty) {
          if (store.state.achievedAchievements["Achieved"].length > 1) {
            showNotification(
                "Sehr gut! Du hast ${store.state
                    .achievedAchievements["Achieved"]
                    .length} Achievement erhalten",
                "");
          } else if (store.state.achievedAchievements["Achieved"].length == 1) {
            showNotification(
                "Sehr gut! Du hast ein Achievement erhalten",
                store.state.achievedAchievements["Achieved"].values
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
