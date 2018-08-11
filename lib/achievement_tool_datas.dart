import 'package:project_bachelorapplication/models/achievement_tool.dart';

  Challenge challenge1 = new Challenge("Beginne deine Einleitung", "Beginne deine Einleitung, um den ersten Schritt auf dem Weg zur fertigen Bachelorarbeit zu tätigen");
  Challenge challenge2 = new Challenge("Beginne deine Zweileitung", "Beginne deine Zweileitung, um den zweiten Schritt auf dem Weg zur fertigen Bachelorarbeit zu tätigen");

  Map<String, Challenge> challenges = {
    challenge1.title: challenge1,
    challenge2.title: challenge2,
  };

  Property prop1 = new Property("Beginne deine Einleitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property prop2 = new Property("Beginne deine Zweileitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property prop3 = new Property("Lege einen Meilenstein an", 0, ACTIVE_IF_EQUALS_TO, 1);

  Achievement achievement1 = Achievement("1", "Dein erster Schritt ist getan...", AchievementType.beginningPhase, [prop1], false, null);
  Achievement achievement2 = Achievement("2", "Voll bei der Sache!", AchievementType.beginningPhase, [prop2],false, null);
  Achievement achievement3 = Achievement("3", "Nicht schlecht! ... für den Anfang ...", AchievementType.special, [prop1, prop2], false, null);
  Achievement achievement4 = Achievement("4", "Eine gute Planung ist der Schlüssel zum Erfolg", AchievementType.special, [prop3], false, null);

  Map<String, Achievement> achievements = {
    achievement1.id : achievement1,
    achievement2.id : achievement2,
    achievement3.id : achievement3,
    achievement4.id : achievement4,
  };

  Map<String, Property> properties = {
    prop1.name: prop1,
    prop2.name: prop2,
    prop3.name: prop3,
  };
