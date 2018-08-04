import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/reducers/achievement_tool_reducers.dart';
import 'package:project_bachelorapplication/reducers/challenge_tool_reducers.dart';
import 'package:project_bachelorapplication/reducers/information_tool_reducer.dart';
import 'package:project_bachelorapplication/reducers/milestone_tool_reducers.dart';
import 'package:redux_persist/redux_persist.dart';

AppState appReducer(AppState state, dynamic action) {

  if (action is LoadedAction<AppState>) {
    return action.state ?? state;

  } else if (!(action is LoadedAction<AppState>)) {
    return state.copyWith(
      informationToolContent: updateActualContent(state.informationToolContent, action),
      currentMilestones: updateMilestones(state.currentMilestones, action),
      selectedMilestone: updateSelectedMilestone(state.selectedMilestone, action),
      properties: updateProperties(state.properties, action),
      achievedAchievements: updateAchievedAchievements(state.achievedAchievements, state.properties, action),
      challenges: updateChallenges(state.challenges, action),
      begin: updateBeginDate(state.begin, action),
      end: updateEndDate(state.end, action),
    );
  }

  return state;
}
