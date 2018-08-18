import 'package:project_bachelorapplication/models/achievement_tool.dart';

  Challenge challenge1 = new Challenge("Beantrage deine Zulassung zur Bachelorarbeit", ChallengeType.beginningPhase, false);
  Challenge challenge2 = new Challenge("Finde das Thema deiner Bachelorarbeit", ChallengeType.beginningPhase, false);
  Challenge challenge3 = new Challenge("Suche dir deinen Betreuer/deine Firma für die Bachelorarbeit", ChallengeType.beginningPhase, false);
  Challenge challenge4 = new Challenge("Bereite deinen Arbeitsplatz für die Arbeit vor", ChallengeType.beginningPhase, false);
  Challenge challenge5 = new Challenge("Schreibe deine Aufgabenstellung", ChallengeType.beginningPhase, false);
  Challenge challenge6 = new Challenge("Erstelle die Gliederung für deine Arbeit", ChallengeType.beginningPhase, false);
  Challenge challenge7 = new Challenge("Erstelle deinen Zeitplan", ChallengeType.beginningPhase, false);
  Challenge challenge8 = new Challenge("Arbeite dich in deine Schreibumgebung ein (Beispiel „LaTeX“)", ChallengeType.beginningPhase, false);
  Challenge challenge9 = new Challenge("Erarbeite deine Recherchegrundlagen", ChallengeType.beginningPhase, false);
  Challenge challenge10 = new Challenge("Erstelle die Ordnerstruktur für die Organisation deines Projektes", ChallengeType.beginningPhase, false);
  Challenge challenge11 = new Challenge("Kümmere dich um eine geeignete Versionsverwaltung (Beispiel „GitHub“)", ChallengeType.beginningPhase, false);
  Challenge challenge12 = new Challenge("Suche dir eine geeignete Vorlage für deine gewählte Schreibumgebung", ChallengeType.beginningPhase, false);
  Challenge challenge13 = new Challenge("Lasse deine Prüfung Anmelden", ChallengeType.beginningPhase, false);
  Challenge challenge14 = new Challenge("Kümmere dich bereits frühzeitig um mögliche Korrekturleser", ChallengeType.beginningPhase, false);
  Challenge challenge15 = new Challenge("Besorge dir Nervennahrung für die Bearbeitungszeit", ChallengeType.beginningPhase, false);
  Challenge challenge16 = new Challenge("Beschreibe die für den Leser relevanten Rechercheinformationen in deinem Grundlagenkapitel", ChallengeType.processingPhase, false);
  Challenge challenge17 = new Challenge("Stelle den getätigten Arbeitsinhalt in deinem Hauptteil dar", ChallengeType.processingPhase, false);
  Challenge challenge18 = new Challenge("Fasse deine Ergebnisse in dem Abschlusskapitel zusammen", ChallengeType.processingPhase, false);
  Challenge challenge19 = new Challenge("Überprüfe alle Kapitel deiner Bachelorarbeit auf Konsistenz", ChallengeType.processingPhase, false);
  Challenge challenge20 = new Challenge("Suche dir deinen Zweitprüfer", ChallengeType.processingPhase, false);
  Challenge challenge21 = new Challenge("Lasse deine Arbeit Korrekturlesen", ChallengeType.conclusionPhase, false);
  Challenge challenge22 = new Challenge("Finalisiere deine Bachelorarbeit durch eine abschließende Überarbeitung", ChallengeType.conclusionPhase, false);
  Challenge challenge23 = new Challenge("Lasse deine Arbeit in einem Druckgeschäft geeignet binden (ca. 1-2 Tage Dauer)", ChallengeType.conclusionPhase, false);
  Challenge challenge24 = new Challenge("Führe die Abgabe deiner Bachelorarbeit durch", ChallengeType.conclusionPhase, false);
  Challenge challenge25 = new Challenge("Bereite deine Präsentation für das Kolloquium vor", ChallengeType.conclusionPhase, false);
  Challenge challenge26 = new Challenge("Führe deine Präsentation im Kolloquium", ChallengeType.conclusionPhase, false);

  Map<String, Challenge> challenges = {
    challenge1.title: challenge1,
    challenge2.title: challenge2,
    challenge3.title: challenge3,
    challenge4.title: challenge4,
    challenge5.title: challenge5,
    challenge6.title: challenge6,
    challenge7.title: challenge7,
    challenge8.title: challenge8,
    challenge9.title: challenge9,
    challenge10.title: challenge10,
    challenge11.title: challenge11,
    challenge12.title: challenge12,
    challenge13.title: challenge13,
    challenge14.title: challenge14,
    challenge15.title: challenge15,
    challenge16.title: challenge16,
    challenge17.title: challenge17,
    challenge18.title: challenge18,
    challenge19.title: challenge19,
    challenge20.title: challenge20,
    challenge21.title: challenge21,
    challenge22.title: challenge22,
    challenge23.title: challenge23,
    challenge24.title: challenge24,
    challenge25.title: challenge25,
    challenge26.title: challenge26,
  };

  Property propChallenge1 = new Property(challenge1.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge2 = new Property(challenge2.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge3 = new Property(challenge3.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge4 = new Property(challenge4.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge5 = new Property(challenge5.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge6 = new Property(challenge6.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge7 = new Property(challenge7.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge8 = new Property(challenge8.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge9 = new Property(challenge9.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge10 = new Property(challenge10.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge11 = new Property(challenge11.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge12 = new Property(challenge12.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge13 = new Property(challenge13.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge14 = new Property(challenge14.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge15 = new Property(challenge15.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge16 = new Property(challenge16.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge17 = new Property(challenge17.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge18 = new Property(challenge18.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge19 = new Property(challenge19.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge20 = new Property(challenge20.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge21 = new Property(challenge21.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge22 = new Property(challenge22.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge23 = new Property(challenge23.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge24 = new Property(challenge24.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge25 = new Property(challenge25.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propChallenge26 = new Property(challenge26.title, 0, ACTIVE_IF_EQUALS_TO, 1);
  Property propApp1 = new Property("Lege einen Meilenstein an", 0, ACTIVE_IF_EQUALS_TO, 1);

Map<String, Property> properties = {
  propChallenge1.name: propChallenge1,
  propChallenge2.name: propChallenge2,
  propChallenge3.name: propChallenge3,
  propChallenge4.name: propChallenge4,
  propChallenge5.name: propChallenge5,
  propChallenge6.name: propChallenge6,
  propChallenge7.name: propChallenge7,
  propChallenge8.name: propChallenge8,
  propChallenge9.name: propChallenge9,
  propChallenge10.name: propChallenge10,
  propChallenge11.name: propChallenge11,
  propChallenge12.name: propChallenge12,
  propChallenge13.name: propChallenge13,
  propChallenge14.name: propChallenge14,
  propChallenge15.name: propChallenge15,
  propChallenge16.name: propChallenge16,
  propChallenge17.name: propChallenge17,
  propChallenge18.name: propChallenge18,
  propChallenge19.name: propChallenge19,
  propChallenge20.name: propChallenge20,
  propChallenge21.name: propChallenge21,
  propChallenge22.name: propChallenge22,
  propChallenge23.name: propChallenge23,
  propChallenge24.name: propChallenge24,
  propChallenge25.name: propChallenge25,
  propChallenge26.name: propChallenge26,
  propApp1.name : propApp1
};

  Achievement achievementChallenge1   = Achievement("C1", "Dein erster Schritt ist getan!",  AchievementType.beginningPhase, [propChallenge1], false, null);
  Achievement achievementChallenge2   = Achievement("C2", "Dieses Thema will ich haben! Kein anderes!",  AchievementType.beginningPhase, [propChallenge2], false, null);
  Achievement achievementChallenge3   = Achievement("C3", "In guten Händen…",  AchievementType.beginningPhase, [propChallenge3], false, null);
  Achievement achievementChallenge4   = Achievement("C4", "Genug Platz für Snacks, Arbeit und Snacks!",  AchievementType.beginningPhase, [propChallenge4], false, null);
  Achievement achievementChallenge5   = Achievement("C5", "Gratulation! Die Probleme sind klar. Jetzt kommst du!",  AchievementType.beginningPhase, [propChallenge5], false, null);
  Achievement achievementChallenge6   = Achievement("C6", "Alles in Reih‘ und Glied",  AchievementType.beginningPhase, [propChallenge6], false, null);
  Achievement achievementChallenge7   = Achievement("C7", "Pünktlich wie die Deutsche Bahn",  AchievementType.beginningPhase, [propChallenge7], false, null);
  Achievement achievementChallenge8   = Achievement("C8", "Exzellente Vorbereitung!",  AchievementType.beginningPhase, [propChallenge8], false, null);
  Achievement achievementChallenge9   = Achievement("C9", "So viel Text! … und so wenig Inhalt?",  AchievementType.beginningPhase, [propChallenge9], false, null);
  Achievement achievementChallenge10  = Achievement("C10", "Alles da, wo es hingehört!", AchievementType.beginningPhase, [propChallenge10], false, null);
  Achievement achievementChallenge11  = Achievement("C11", "Sicher ist sicher!", AchievementType.beginningPhase, [propChallenge11], false, null);
  Achievement achievementChallenge12  = Achievement("C12", "Das Rad nicht neu erfinden…", AchievementType.beginningPhase, [propChallenge12], false, null);
  Achievement achievementChallenge13  = Achievement("C13", "Schnall dich an! Jetzt geht es los!", AchievementType.beginningPhase, [propChallenge13], false, null);
  Achievement achievementChallenge14  = Achievement("C14", "Das ist wohl eher keine Einschlaflektüre…", AchievementType.beginningPhase, [propChallenge14], false, null);
  Achievement achievementChallenge15  = Achievement("C15", "Mühsam ernährt sich der Student.", AchievementType.beginningPhase, [propChallenge15], false, null);
  Achievement achievementChallenge16  = Achievement("C16", "Das weiß doch jedes Kind…", AchievementType.processingPhase, [propChallenge16], false, null);
  Achievement achievementChallenge17  = Achievement("C17", "Der schwerste Teil ist geschafft!", AchievementType.processingPhase, [propChallenge17], false, null);
  Achievement achievementChallenge18  = Achievement("C18", "Alle Fäden laufen zusammen...", AchievementType.processingPhase, [propChallenge18], false, null);
  Achievement achievementChallenge19  = Achievement("C19", "Passt, wackelt und hat Luft!", AchievementType.processingPhase, [propChallenge19], false, null);
  Achievement achievementChallenge20  = Achievement("C20", "Vier Augen sehen besser als zwei.", AchievementType.processingPhase, [propChallenge20], false, null);
  Achievement achievementChallenge21  = Achievement("C21", "Mein Fräund, die Rehctschreibunck", AchievementType.conclusionPhase, [propChallenge21], false, null);
  Achievement achievementChallenge22  = Achievement("C22", "Letzter Feinschliff", AchievementType.conclusionPhase, [propChallenge22], false, null);
  Achievement achievementChallenge23  = Achievement("C23", "Unter Druck zum Diamanten", AchievementType.conclusionPhase, [propChallenge23], false, null);
  Achievement achievementChallenge24  = Achievement("C24", "FunFact: Einsteins Doktorarbeit umfasste 17 Seiten", AchievementType.conclusionPhase, [propChallenge24], false, null);
  Achievement achievementChallenge25  = Achievement("C25", "Fast geschafft!", AchievementType.conclusionPhase, [propChallenge25], false, null);
  Achievement achievementChallenge26  = Achievement("C26", "Feier schön! Du hast es dir verdient.", AchievementType.conclusionPhase, [propChallenge26], false, null);

  Achievement achievementSpecial1 = Achievement("S1", "Planungs-Ass", AchievementType.special, [
    propChallenge1,
    propChallenge2,
    propChallenge3,
    propChallenge4,
    propChallenge5,
    propChallenge6,
    propChallenge7,
    propChallenge8,
    propChallenge9,
    propChallenge10,
    propChallenge11,
    propChallenge12,
    propChallenge13,
    propChallenge14,
    propChallenge15
  ], false, null);

  Achievement achievementSpecial2 = Achievement("S2", "Herausforderungs-Jäger", AchievementType.special, [
    propChallenge16,
    propChallenge17,
    propChallenge18,
    propChallenge19,
    propChallenge20,
  ], false, null);

  Achievement achievementSpecial3 = Achievement("S3", "Arbeitstier-Ausstrahlung", AchievementType.special, [
    propChallenge21,
    propChallenge22,
    propChallenge23,
    propChallenge24,
    propChallenge25,
    propChallenge26,
  ], false, null);

  Achievement achievementSpecial4 = Achievement("S4", "Perfektionist", AchievementType.special, [
    propChallenge1,
    propChallenge2,
    propChallenge3,
    propChallenge4,
    propChallenge5,
    propChallenge6,
    propChallenge7,
    propChallenge8,
    propChallenge9,
    propChallenge10,
    propChallenge11,
    propChallenge12,
    propChallenge13,
    propChallenge14,
    propChallenge15,
    propChallenge16,
    propChallenge17,
    propChallenge18,
    propChallenge19,
    propChallenge20,
    propChallenge21,
    propChallenge22,
    propChallenge23,
    propChallenge24,
    propChallenge25,
    propChallenge26,
  ], false, null);

  Achievement achievementSpecial5 = Achievement("S5", "Eine gute Planung ist der Schlüssel zum Erfolg", AchievementType.special, [propApp1], false, null);

  Map<String, Achievement> achievements = {
    achievementChallenge1.id : achievementChallenge1,
    achievementChallenge2.id : achievementChallenge2,
    achievementChallenge3.id : achievementChallenge3,
    achievementChallenge4.id : achievementChallenge4,
    achievementChallenge5.id : achievementChallenge5,
    achievementChallenge6.id : achievementChallenge6,
    achievementChallenge7.id : achievementChallenge7,
    achievementChallenge8.id : achievementChallenge8,
    achievementChallenge9.id : achievementChallenge9,
    achievementChallenge10.id : achievementChallenge10,
    achievementChallenge11.id : achievementChallenge11,
    achievementChallenge12.id : achievementChallenge12,
    achievementChallenge13.id : achievementChallenge13,
    achievementChallenge14.id : achievementChallenge14,
    achievementChallenge15.id : achievementChallenge15,
    achievementChallenge16.id : achievementChallenge16,
    achievementChallenge17.id : achievementChallenge17,
    achievementChallenge18.id : achievementChallenge18,
    achievementChallenge19.id : achievementChallenge19,
    achievementChallenge20.id : achievementChallenge20,
    achievementChallenge21.id : achievementChallenge21,
    achievementChallenge22.id : achievementChallenge22,
    achievementChallenge23.id : achievementChallenge23,
    achievementChallenge24.id : achievementChallenge24,
    achievementChallenge25.id : achievementChallenge25,
    achievementChallenge26.id : achievementChallenge26,
    achievementSpecial1.id : achievementSpecial1,
    achievementSpecial2.id : achievementSpecial2,
    achievementSpecial3.id : achievementSpecial3,
    achievementSpecial4.id : achievementSpecial4,
    achievementSpecial5.id : achievementSpecial5,
  };


