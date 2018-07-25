import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/information_tool.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';

class AppState {
  final Content informationToolContent;
  final Map<String, Milestone> currentMilestones;
  final Map<String, Property> properties;
  //final Map<String, Achievement> activeAchievements;

  final Map<String, Map<String, Achievement>> achievedAchievements;

  final Map<String, Challenge> challenges;

  AppState(this.informationToolContent, this.currentMilestones, this.properties, this.achievedAchievements, this.challenges);
}
