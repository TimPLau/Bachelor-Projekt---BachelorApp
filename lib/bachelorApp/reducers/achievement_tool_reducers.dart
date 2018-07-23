import 'package:project_bachelorapplication/bachelorApp/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/achievement_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/achievement_tool_datas.dart';

AchievementManager updateCurrentAchievements(AchievementManager current, action) {

  if (action is AddMilestoneAction) {
     current.setPropertyValue(AchievementLookUp.firstMilestone.name, 1);

     return current;
  }

  if (action is ChangeStateChallengeAction) {
    current.setPropertyValue(action.challenge.title, 1);

    return current;
  }

  return current;
}
