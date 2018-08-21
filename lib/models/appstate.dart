import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/main.dart';

part 'appstate.g.dart';

Map<String, Content> appContent;

@immutable
@JsonSerializable()
class AppState extends Object with _$AppStateSerializerMixin {
  final Map<String, Content> informationToolContent;
  final Map<String, Milestone> currentMilestones;
  final Milestone selectedMilestone;
  final Map<String, Property> properties;
  final Map<String, Map<String, Achievement>> achievedAchievements;
  final Map<String, Challenge> challenges;
  final DateTime begin;
  final DateTime end;

  AppState(
      {this.informationToolContent,
      this.currentMilestones,
      this.selectedMilestone,
      this.properties,
      this.achievedAchievements,
      this.challenges,
      this.begin,
      this.end});

  AppState copyWith(
      {Map<String, Content> informationToolContent,
      Map<String, Milestone> currentMilestones,
      Milestone selectedMilestone,
      Map<String, Property> properties,
      Map<String, Map<String, Achievement>> achievedAchievements,
      Map<String, Challenge> challenges,
      DateTime begin,
      DateTime end}) {
    return new AppState(
      informationToolContent: informationToolContent ?? this.informationToolContent,
      currentMilestones: currentMilestones ?? this.currentMilestones,
      selectedMilestone: selectedMilestone ?? this.selectedMilestone,
      properties: properties ?? this.properties,
      achievedAchievements: achievedAchievements ?? this.achievedAchievements,
      challenges: challenges ?? this.challenges,
      begin: begin ?? this.begin,
      end: end ?? this.end,
    );
  }

  factory AppState.fromJson(dynamic json) {
    return _$AppStateFromJson(json);
  }

  static AppState fromJsonDecoder(dynamic json) => AppState.fromJson(json);
}
