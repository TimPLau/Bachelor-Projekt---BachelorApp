import 'dart:async';

import 'package:project_bachelorapplication/models/achievement_tool.dart';


class ChangeStateChallengeAction{
  Challenge challenge;

  ChangeStateChallengeAction(this.challenge);
}

class CheckForAchieveAction{
  Map<String, Achievement> actualAchievements;

  CheckForAchieveAction(this.actualAchievements);
}

class SendAchievementNotificationAction{
  Completer completer;

  SendAchievementNotificationAction({Completer completer})
      : this.completer = completer ?? new Completer();
}

class ClearAchievedAchievementsAction{


  ClearAchievedAchievementsAction();
}

class ClearAchievedAction{

  ClearAchievedAction();
}