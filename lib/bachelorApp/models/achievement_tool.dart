//https://gamedevelopment.tutsplus.com/tutorials/how-to-code-unlockable-achievements-for-your-game-a-simple-approach--gamedev-6012

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

class AchievementManager {
  static const String ACTIVE_IF_GREATER_THAN = ">";
  static const String ACTIVE_IF_LESS_THAN = "<";
  static const String ACTIVE_IF_EQUALS_TO = "==";

  Map<String, Property> properties;
  Map<String, Achievement> achievements;

  AchievementManager(this.properties, this.achievements);

  /*addProperties(var name, var initialValue, var activationRule,
      var activationValue) {
    properties[name] =
        new Property(name, initialValue, activationRule, activationValue);
  }*/

  /*addAchievements(
      String title, AchievementType type, List<Property> properties) {
    achievements[title] = new Achievement(title, type, properties);
  }*/

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

    checkAchievements();

  }

  List<Achievement> checkAchievements() {
    List<Achievement> ret = [];

    for(Achievement achievement in this.achievements.values.toList()){
      if(achievement.completed == false){
        if(achievement.checkAchievement() == true) ret.add(achievement);
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
      case AchievementManager.ACTIVE_IF_GREATER_THAN:
        return currentValue > activationValue;
        break;
      case AchievementManager.ACTIVE_IF_LESS_THAN:
        return currentValue < activationValue;
        break;
      case AchievementManager.ACTIVE_IF_EQUALS_TO:
        return currentValue == activationValue;
        break;
    }
    return false;
  }
}

enum AchievementType { low, medium, high, special }

class AchievementLibrary {}
