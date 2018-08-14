import 'package:project_bachelorapplication/models/achievement_tool.dart';

  Challenge challenge1 = new Challenge("Beginne deine Einleitung", ChallengeType.beginningPhase, false);
  Challenge challenge2 = new Challenge("Beginne deine Zweileitung", ChallengeType.beginningPhase, false);
  Challenge challenge3 = new Challenge("Beginne deine Dreileitung", ChallengeType.processingPhase, false);
  Challenge challenge4 = new Challenge("Beginne deine Vierleitung", ChallengeType.conclusionPhase, false);

  Map<String, Challenge> challenges = {
    challenge1.title: challenge1,
    challenge2.title: challenge2,
    challenge3.title: challenge3,
    challenge4.title: challenge4,
  };

  Property prop1 = new Property("Beginne deine Einleitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property prop2 = new Property("Beginne deine Zweileitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property prop4 = new Property("Beginne deine Dreileitung", 0, ACTIVE_IF_EQUALS_TO, 1);
  Property prop5 = new Property("Beginne deine Vierleitung", 0, ACTIVE_IF_EQUALS_TO, 1);

  Property prop3 = new Property("Lege einen Meilenstein an", 0, ACTIVE_IF_EQUALS_TO, 1);

  Achievement achievement1 = Achievement("1", "Dein erster Schritt ist getan...", AchievementType.beginningPhase, [prop1], false, null);
  Achievement achievement2 = Achievement("2", "Dein zweiter Schritt ist getan...", AchievementType.beginningPhase, [prop2],false, null);
  Achievement achievement5 = Achievement("5", "Dein dritter Schritt ist getan...", AchievementType.processingPhase, [prop4], false, null);
  Achievement achievement6 = Achievement("6", "Dein vierter Schritt ist getan...", AchievementType.conclusionPhase, [prop5],false, null);

  Achievement achievement3 = Achievement("3", "Nicht schlecht! ... für den Anfang ...", AchievementType.special, [prop1, prop2], false, null);
  Achievement achievement4 = Achievement("4", "Eine gute Planung ist der Schlüssel zum Erfolg", AchievementType.special, [prop3], false, null);

  Map<String, Achievement> achievements = {
    achievement1.id : achievement1,
    achievement2.id : achievement2,
    achievement3.id : achievement3,
    achievement4.id : achievement4,
    achievement5.id : achievement5,
    achievement6.id : achievement6,
  };

  Map<String, Property> properties = {
    prop1.name: prop1,
    prop2.name: prop2,
    prop3.name: prop3,
    prop4.name: prop4,
    prop5.name: prop5,
  };
