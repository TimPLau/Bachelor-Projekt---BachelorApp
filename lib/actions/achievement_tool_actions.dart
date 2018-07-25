import 'package:project_bachelorapplication/models/achievement_tool.dart';


class ChangeStateChallengeAction{
  Challenge challenge;

  ChangeStateChallengeAction(this.challenge);
}

class CheckForAchieveAction{
  Map<String, Achievement> actualAchievements;

  CheckForAchieveAction(this.actualAchievements);
}

class ClearAchievedAchievementsAction{
  ClearAchievedAchievementsAction();
}