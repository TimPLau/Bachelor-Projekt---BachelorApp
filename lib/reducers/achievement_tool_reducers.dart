import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';

Map<String, Property> updateProperties(Map<String, Property> current, action) {
  if (action is AddMilestoneAction)
    current =
        setPropertyValue(current, AchievementLookUp.firstMilestone.name, 1);

  if (action is ChangeStateChallengeAction)
    current = setPropertyValue(current, action.challenge.title, 1);

  return current;
}

Map<String, Map<String, Achievement>> updateAchievedAchievements(
    Map<String, Map<String, Achievement>> current, action) {

  if (action is ClearAchievedAchievementsAction) {
    current["Recognized"].addAll(current["NotRecognized"]);
    current["NotRecognized"] = {};
    return current;
  }

  if (action is CheckForAchieveAction) {

    Map<String, Achievement> newAchievements =
        setAchievedAchievements(current["AllAchievements"]);
    current["Achieved"].addAll(newAchievements);

    for (Achievement achievement in newAchievements.values.toList()) {
      if (!current["NotRecognized"].containsKey(achievement.title) &&
          !current["Recognized"].containsKey(achievement.title)) {
        current["NotRecognized"][achievement.title] = achievement;
      }
    }

      if (newAchievements.length > 1) {
        showNotification(
            "Sehr gut! Du hast ${newAchievements
                .length} Achievement erhalten",
            "");
      } else if (newAchievements.length == 1){
        showNotification(
            "Sehr gut! Du hast ein Achievement erhalten", newAchievements.values.toList()[0].title);
      }

    return current;
  }
  return current;
}

Map<String, Property> setPropertyValue(
    Map<String, Property> properties, String name, int newValue) {
  Map<String, Property> ret = properties;
  Property property = ret[name];

  switch (property.activationRule) {
    case ACTIVE_IF_GREATER_THAN:
      property.currentValue =
          (newValue > property.currentValue) ? newValue : property.currentValue;
      break;
    case ACTIVE_IF_LESS_THAN:
      property.currentValue =
          (newValue < property.currentValue) ? newValue : property.currentValue;
      break;
    case ACTIVE_IF_EQUALS_TO:
      property.currentValue = newValue;
      break;
  }

  return ret;
}

Map<String, Achievement> setAchievedAchievements(
    Map<String, Achievement> activeAchievements) {
  Map<String, Achievement> ret = new Map<String, Achievement>();

  for (Achievement achievement in activeAchievements.values.toList()) {
    if (achievement.completed == false) {
      if (achievement.checkAchievement() == true) {
        achievement.completed = true;
        ret[achievement.title] = achievement;
      }
    }
  }

  return ret;
}