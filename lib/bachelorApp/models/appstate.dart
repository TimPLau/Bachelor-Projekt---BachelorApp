import 'package:project_bachelorapplication/bachelorApp/models/achievement_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/milestone_tool.dart';

class AppState {
  Content informationToolContent;
  TaskManager taskManager;
  AchievementManager achievementManager;
  Map<String, Challenge> challenges;

  AppState(this.informationToolContent, this.taskManager, this.achievementManager, this.challenges);
}
