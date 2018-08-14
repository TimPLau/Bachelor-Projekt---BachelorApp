// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => new AppState(
    informationToolContent: globalAppContent,
    currentMilestones: json['currentMilestones'] == null
        ? null
        : new Map<String, Milestone>.fromIterables(
            (json['currentMilestones'] as Map<String, dynamic>).keys,
            (json['currentMilestones'] as Map).values.map((e) => e == null
                ? null
                : new Milestone.fromJson(e as Map<String, dynamic>))),
    selectedMilestone: json['selectedMilestone'] == null
        ? null
        : new Milestone.fromJson(
            json['selectedMilestone'] as Map<String, dynamic>),
    properties: json['properties'] == null
        ? null
        : new Map<String, Property>.fromIterables(
            (json['properties'] as Map<String, dynamic>).keys,
            (json['properties'] as Map).values.map((e) => e == null ? null : new Property.fromJson(e as Map<String, dynamic>))),
    achievedAchievements: json['achievedAchievements'] == null ? null : new Map<String, Map<String, Achievement>>.fromIterables((json['achievedAchievements'] as Map<String, dynamic>).keys, (json['achievedAchievements'] as Map).values.map((e) => e == null ? null : new Map<String, Achievement>.fromIterables((e as Map<String, dynamic>).keys, (e as Map).values.map((e) => e == null ? null : new Achievement.fromJson(e as Map<String, dynamic>))))),
    challenges: json['challenges'] == null ? null : new Map<String, Challenge>.fromIterables((json['challenges'] as Map<String, dynamic>).keys, (json['challenges'] as Map).values.map((e) => e == null ? null : new Challenge.fromJson(e as Map<String, dynamic>))),
    begin: json['begin'] == null ? null : DateTime.parse(json['begin'] as String),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String));

abstract class _$AppStateSerializerMixin {
  Map<String, Content> get informationToolContent;
  Map<String, Milestone> get currentMilestones;
  Milestone get selectedMilestone;
  Map<String, Property> get properties;
  Map<String, Map<String, Achievement>> get achievedAchievements;
  Map<String, Challenge> get challenges;
  DateTime get begin;
  DateTime get end;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'informationToolContent': informationToolContent,
        'currentMilestones': currentMilestones,
        'selectedMilestone': selectedMilestone,
        'properties': properties,
        'achievedAchievements': achievedAchievements,
        'challenges': challenges,
        'begin': begin?.toIso8601String(),
        'end': end?.toIso8601String()
      };
}
