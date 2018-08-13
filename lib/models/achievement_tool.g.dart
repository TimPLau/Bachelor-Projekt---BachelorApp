// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => new Challenge(
    json['title'] as String,
    json['type'] == null
        ? null
        : ChallengeType.values.singleWhere(
            (x) => x.toString() == 'ChallengeType.${json['type']}'),
    json['completed'] as bool);

abstract class _$ChallengeSerializerMixin {
  String get title;
  ChallengeType get type;
  bool get completed;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
    'type': type == null ? null : type.toString().split('.')[1],
        'completed': completed
      };
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) => new Achievement(
    json['id'] as String,
    json['title'] as String,
    json['type'] == null
        ? null
        : AchievementType.values.singleWhere(
            (x) => x.toString() == 'AchievementType.${json['type']}'),
    (json['properties'] as List)
        ?.map((e) =>
            e == null ? null : new Property.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['completed'] as bool,
    json['completeDate'] == null
        ? null
        : DateTime.parse(json['completeDate'] as String));

abstract class _$AchievementSerializerMixin {
  String get id;
  String get title;
  bool get completed;
  AchievementType get type;
  List<Property> get properties;
  DateTime get completeDate;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'completed': completed,
        'type': type == null ? null : type.toString().split('.')[1],
        'properties': properties,
        'completeDate': completeDate?.toIso8601String()
      };
}

Property _$PropertyFromJson(Map<String, dynamic> json) => new Property(
    json['name'] as String,
    json['initialValue'] as int,
    json['activationRule'] as String,
    json['activationValue'] as int,
    json['currentValue'] as int);

abstract class _$PropertySerializerMixin {
  String get name;
  int get currentValue;
  String get activationRule;
  int get activationValue;
  int get initialValue;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'currentValue': currentValue,
        'activationRule': activationRule,
        'activationValue': activationValue,
        'initialValue': initialValue
      };
}
