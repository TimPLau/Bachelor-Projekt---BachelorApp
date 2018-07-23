import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/achievement_tool_reducers.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/challenge_tool_reducers.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/information_tool_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/milestone_tool_reducers.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    updateActualContent(state.informationToolContent, action),
    updateTasks(state.taskManager, action),
    updateCurrentAchievements(state.achievementManager, action),
    updateChallenges(state.challenges, action),
  );
}
