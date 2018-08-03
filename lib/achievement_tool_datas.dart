import 'package:project_bachelorapplication/models/achievement_tool.dart';

  Property einleitung = new Property("Beginne deine Einleitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property zweileitung = new Property("Beginne deine Zweileitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property firstMilestone = new Property("Lege einen Meilenstein an", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property allBeginner = new Property("Schließe alle Achievements der Kategorie ANFANGSPHASE ab", 0, ACTIVE_IF_EQUALS_TO, 1);

  Map<String, Achievement> achievements = {
    "Du hast deine Einleitung begonnen": Achievement("Du hast deine Einleitung begonnen", AchievementType.beginningPhase, [einleitung]),
    "Du hast deine Zweileitung begonnen": Achievement("Du hast deine Zweileitung begonnen", AchievementType.beginningPhase, [zweileitung]),
    "Du hast alle Einleitungsachievements abgeschlossen": Achievement("Du hast alle Einleitungsachievements abgeschlossen", AchievementType.special, [einleitung, zweileitung]),
    "Dein erster Meilenstein ist gesetzt": Achievement("Dein erster Meilenstein ist gesetzt", AchievementType.special, [firstMilestone]),
  };

  Map<String, Property> properties = {
    firstMilestone.name: firstMilestone,
    allBeginner.name: allBeginner,
    einleitung.name: einleitung,
    zweileitung.name: zweileitung,
  };

  Map<String, Challenge> challenges = {
    "Beginne deine Einleitung": new Challenge("Beginne deine Einleitung", "Beginne deine Einleitung, um den ersten Schritt auf dem Weg zur fertigen Bachelorarbeit zu tätigen"),
    "Beginne deine Zweileitung": new Challenge("Beginne deine Zweileitung", "Beginne deine Zweileitung, um den zweiten Schritt auf dem Weg zur fertigen Bachelorarbeit zu tätigen"),
  };
