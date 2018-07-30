//https://gamedevelopment.tutsplus.com/tutorials/how-to-code-unlockable-achievements-for-your-game-a-simple-approach--gamedev-6012

import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'achievement_tool.g.dart';

const String ACTIVE_IF_GREATER_THAN = ">";
const String ACTIVE_IF_LESS_THAN = "<";
const String ACTIVE_IF_EQUALS_TO = "==";

@JsonSerializable()
class Challenge extends Object with _$ChallengeSerializerMixin{
  final String title;
  final String description;
  bool completed;

  Challenge( this.title,  this.description, [this.completed = false]);

  changeState() {
    this.completed = (this.completed == false) ? true : false;
  }

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

}

@JsonSerializable()
class Achievement extends Object with _$AchievementSerializerMixin{
  String title;
  bool completed;
  AchievementType type;
  List<Property> properties;


  Achievement(this.title, this.type, this.properties, [this.completed = false]);

  bool checkAchievement() {

    if (this.completed == false) {
      print("f");
      for (Property property in properties) {
        print(property.name);
        print(property.isActive());
        print(property.currentValue);
        print(property.activationValue);
        if (property.isActive() == false) return false;
      }
      this.completed = true;
    }

    return true;
  }

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

}

@JsonSerializable()
class Property extends Object with _$PropertySerializerMixin{
  String name;
  int currentValue;
  String activationRule;
  int activationValue;
  int initialValue;

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
        print(currentValue == activationValue);
        return currentValue == activationValue;
        break;
    }
    return false;
  }

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);
}

enum AchievementType { low, medium, high, special }

Color getAchievementTypeColor(Achievement achievement){
  Color ret;

  switch(achievement.type){
    case AchievementType.low: ret = Colors.yellow; break;
    case AchievementType.medium: ret = Colors.orangeAccent; break;
    case AchievementType.high: ret = Colors.red; break;
    case AchievementType.special: ret = Colors.blue; break;
    default: ret = Colors.white10;
  }

  return ret;
}
