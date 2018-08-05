import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';

Map<String, Property> updateProperties(Map<String, Property> current, action) {
  if (action is AddMilestoneAction) {
    current = setPropertyValue(current, firstMilestone.name, 1);
  }

  if (action is ChangeStateChallengeAction) {
    current = setPropertyValue(current, action.challenge.title, 1);
  }

  return current;
}

Map<String, Map<String, Achievement>> updateAchievedAchievements(
    Map<String, Map<String, Achievement>> current,
    Map<String, Property> properties,
    action) {

  if (action is ClearAchievedAchievementsAction) {
    current[RECOGNIZED].addAll(current[NOT_RECOGNIZED]);
    current[NOT_RECOGNIZED] = {};
    return current;
  }

  if (action is ClearAchievedAction) {
    current[ACHIEVED] = {};
    return current;
  }

  if (action is CheckForAchieveAction) {
    return setAchievedAchievements(properties, current);
  }

  return current;
}

Map<String, Map<String, Achievement>> setAchievedAchievements(
    Map<String, Property> properties,
    Map<String, Map<String, Achievement>> achievements) {

  for (Achievement achievement in achievements[ALL_ACHIEVEMENTS].values.toList()) {

    if (achievement.completed == false) {

      if (checkAchievement(achievement, properties) == true) {
        Achievement newAchievement = new Achievement(achievement.title, achievement.type, achievement.properties, true);

        achievements[ALL_ACHIEVEMENTS][achievement.title] = newAchievement;
        achievements[ACHIEVED][achievement.title] = newAchievement;

        if (!achievements[NOT_RECOGNIZED].containsKey(newAchievement.title) &&
            !achievements[RECOGNIZED].containsKey(newAchievement.title)) {
            achievements[NOT_RECOGNIZED][newAchievement.title] = newAchievement;
        }

      }
    }

  }
  return achievements;
}

bool checkAchievement(Achievement achievement, Map<String, Property> properties) {
  for (Property property in achievement.properties) {

    if (properties[property.name].isActive() == false) return false;

  }

  return true;
}

Map<String, Property> setPropertyValue(
    Map<String, Property> properties, String name, int newValue) {
  Map<String, Property> ret = properties;

  Property oldProperty = properties[name];

  switch (properties[name].activationRule) {
    case ACTIVE_IF_GREATER_THAN:
      properties[name] = (newValue > oldProperty.currentValue)
          ? new Property(oldProperty.name, oldProperty.initialValue,
              oldProperty.activationRule, oldProperty.activationValue, newValue)
          : oldProperty;
      break;
    case ACTIVE_IF_LESS_THAN:
      properties[name] = (newValue < oldProperty.currentValue)
          ? new Property(oldProperty.name, oldProperty.initialValue,
              oldProperty.activationRule, oldProperty.activationValue, newValue)
          : oldProperty;
      break;
    case ACTIVE_IF_EQUALS_TO:
      properties[name] = new Property(
          oldProperty.name,
          oldProperty.initialValue,
          oldProperty.activationRule,
          oldProperty.activationValue,
          newValue);
      break;
  }

  return ret;
}
