import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/information_tool.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';

class AppState {
  Content informationToolContent;
  TaskManager taskManager;
  AchievementManager achievementManager;
  Map<String, Challenge> challenges;

  AppState(this.informationToolContent, this.taskManager, this.achievementManager, this.challenges);
}
