import 'package:project_bachelorapplication/models/achievement_tool.dart';

class AchievementLookUp {
  static Property einleitung = new Property(
      "Beginne deine Einleitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  static Property zweileitung = new Property(
      "Beginne deine Zweileitung", 0, ACTIVE_IF_EQUALS_TO, 1);



  static Property firstMilestone = new Property("Lege einen Meilenstein an", 0,
      ACTIVE_IF_EQUALS_TO, 1);
  static Property allBeginner = new Property(
      "Schließe alle Achievements der Kategorie ANFANGSPHASE ab",
      0,
      ACTIVE_IF_EQUALS_TO,
      1);






  static Map<String, Achievement> achievements = {
    "Du hast deine Einletung begonnen": Achievement(
        "Du hast deine Einletung begonnen",
        AchievementType.low,
        [einleitung]),
    "Du hast deine Zweileitung begonnen": Achievement(
        "Du hast deine Zweileitung begonnen",
        AchievementType.low,
        [zweileitung]),



    "Dein erster Meilenstein ist gesetzt": Achievement(
        "Dein erster Meilenstein ist gesetzt",
        AchievementType.special,
        [firstMilestone]),
    "Du hast alle Einleitungsachievements abgeschlossen": Achievement(
        "Du hast alle Einleitungsachievements abgeschlossen",
        AchievementType.special,
        [einleitung, zweileitung]),
  };

  static Map<String, Property> properties = {
    firstMilestone.name: firstMilestone,
    allBeginner.name: allBeginner,
    einleitung.name: einleitung,
    zweileitung.name: zweileitung,
  };
}
