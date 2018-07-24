import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';

AchievementManager updateCurrentAchievements(AchievementManager current, action) {

  if (action is AddMilestoneAction)
     current.setPropertyValue(AchievementLookUp.firstMilestone.name, 1);

  if (action is ChangeStateChallengeAction)
    current.setPropertyValue(action.challenge.title, 1);

  List<Achievement> achievements = current.checkAchievements();

  if(achievements.length > 0){
    for(Achievement achievement in achievements)
      showNotification("Sehr gut! Du hast eine Achievement erhalten", achievement.title);
  }

  return current;
}
