import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/reducers/achievement_tool_reducers.dart';
import 'package:project_bachelorapplication/reducers/challenge_tool_reducers.dart';
import 'package:project_bachelorapplication/reducers/information_tool_reducer.dart';
import 'package:project_bachelorapplication/reducers/milestone_tool_reducers.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    updateActualContent(state.informationToolContent, action),
    updateTasks(state.taskManager, action),
    updateCurrentAchievements(state.achievementManager, action),
    updateChallenges(state.challenges, action),
  );
}
