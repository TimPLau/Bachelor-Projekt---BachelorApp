//https://gamedevelopment.tutsplus.com/tutorials/how-to-code-unlockable-achievements-for-your-game-a-simple-approach--gamedev-6012

import 'dart:ui';

import 'package:flutter/material.dart';

const String ACTIVE_IF_GREATER_THAN = ">";
const String ACTIVE_IF_LESS_THAN = "<";
const String ACTIVE_IF_EQUALS_TO = "==";

class Challenge {
  String title;
  String description;
  bool completed;

  Challenge(this.title, this.description){
    this.completed = false;
  }

  changeState() {
    this.completed = (this.completed == false) ? true : false;
  }
}

class AchievementHandler {


  Map<String, Property> properties;
  Map<String, Achievement> activeAchievements;
  List<Achievement> achievedAchievements;

  AchievementHandler(this.properties, this.activeAchievements);

  getPropertyValue(String name) {
    return this.properties[name].currentValue;
  }

  setPropertyValue(String name, int newValue) {

    Property property = this.properties[name];

    switch(property.activationRule){
      case ACTIVE_IF_GREATER_THAN: property.currentValue = (newValue > property.currentValue) ? newValue : property.currentValue; break;
      case ACTIVE_IF_LESS_THAN: property.currentValue = (newValue < property.currentValue) ? newValue : property.currentValue; break;
      case ACTIVE_IF_EQUALS_TO: property.currentValue = newValue; break;
    }

  }

  List<Achievement> checkAchievements() {
    List<Achievement> ret = [];

    for(Achievement achievement in this.activeAchievements.values.toList()){
      if(achievement.completed == false){
        if(achievement.checkAchievement() == true) {
          this.achievedAchievements.add(achievement);
          this.activeAchievements.remove(achievement.title);
        }
      }
    }

    return ret;
  }

}

class Achievement {
  String title;
  bool completed;
  AchievementType type;
  List<Property> properties;

  Achievement(this.title, this.type, this.properties){
    this.completed = false;
  }

  bool checkAchievement() {

    if (this.completed == false) {
      for (Property property in properties)
        if (property.isActive() == false) return false;

      this.completed = true;
    }

    return true;
  }
}

class Property{
  String name;
  int currentValue;
  String activationRule;
  int activationValue;
  int initialValue;

  Property(
      this.name, this.initialValue, this.activationRule, this.activationValue){
    currentValue = initialValue;
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
}

enum AchievementType { low, medium, high, special }

class AchievementLibrary {}

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
