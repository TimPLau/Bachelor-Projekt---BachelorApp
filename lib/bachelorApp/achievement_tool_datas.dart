import 'package:project_bachelorapplication/bachelorApp/models/achievement_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/achievement_tool.dart';

final achievements = new AchievementLookUp();

class AchievementLookUp {



  static Property firstMilestone = new Property("Lege einen Meilenstein an", 0,
      AchievementManager.ACTIVE_IF_EQUALS_TO, 1);

  static Property checkKaestchen = new Property("Beginne deine Einleitung", 0,
      AchievementManager.ACTIVE_IF_EQUALS_TO, 1);




  static Map<String, Achievement> achievements = {

    "Dein erster Meilenstein ist gesetzt": Achievement(
        "Dein erster Meilenstein ist gesetzt",
        AchievementType.special,
        [firstMilestone]),

    "Du hast deine Einletung abgeschlossen": Achievement("Du hast deine Einletung abgeschlossen",
        AchievementType.low,
        [checkKaestchen])

  };




  static Map<String, Property> properties = {
    firstMilestone.name : firstMilestone,
    checkKaestchen.name : checkKaestchen,
  };
}
