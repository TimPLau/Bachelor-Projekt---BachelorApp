//https://gamedevelopment.tutsplus.com/tutorials/how-to-code-unlockable-achievements-for-your-game-a-simple-approach--gamedev-6012

import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'achievement_tool.g.dart';

const String ACTIVE_IF_GREATER_THAN = ">";
const String ACTIVE_IF_LESS_THAN = "<";
const String ACTIVE_IF_EQUALS_TO = "==";

@immutable
@JsonSerializable()
class Challenge extends Object with _$ChallengeSerializerMixin{
  final String title;
  final String description;
  final bool completed;

  Challenge( this.title,  this.description, [this.completed = false]);

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

}

@immutable
@JsonSerializable()
class Achievement extends Object with _$AchievementSerializerMixin{
  final String id;
  final String title;
  final bool completed;
  final AchievementType type;
  final List<Property> properties;
  final DateTime completeDate;

  Achievement(this.id, this.title, this.type, this.properties, this.completed, this.completeDate);

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

}

@immutable
@JsonSerializable()
class Property extends Object with _$PropertySerializerMixin{
  final String name;
  final int currentValue;
  final String activationRule;
  final int activationValue;
  final int initialValue;

  Property(
      this.name, this.initialValue, this.activationRule, this.activationValue, [this.currentValue = 0]){
  }

  bool isActive() {
    switch (activationRule) {
      case ACTIVE_IF_GREATER_THAN:
        return currentValue > activationValue;
        break;
      case ACTIVE_IF_LESS_THAN:
        return currentValue < activationValue;
        break;
      case ACTIVE_IF_EQUALS_TO:
        return currentValue == activationValue;
        break;
    }
    return false;
  }

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);
}

enum AchievementType { prePhase , beginningPhase, processingPhase, conclusionPhase , special}

Color getAchievementTypeColor(Achievement achievement){
  Color ret;

  switch(achievement.type){
    case AchievementType.prePhase: ret = Colors.white10; break;
    case AchievementType.beginningPhase: ret = Colors.yellow; break;
    case AchievementType.processingPhase: ret = Colors.orangeAccent; break;
    case AchievementType.conclusionPhase: ret = Colors.red; break;
    case AchievementType.special: ret = Colors.blue; break;
    default: ret = Colors.white10;
  }

  return ret;
}
