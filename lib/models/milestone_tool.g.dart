// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => new Milestone(
    json['title'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['id'] as String,
    (json['taskIDs'] as List<String>)
        ?.map((e) =>
    e == null ? null : e)
        ?.toList(),
    json['description'] as String);

abstract class _$MilestoneSerializerMixin {
  String get id;
  String get title;
  String get description;
  DateTime get date;
  List<String> get taskIDs;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'date': date?.toIso8601String(),
        'taskIDs': taskIDs
      };
}

Task _$TaskFromJson(Map<String, dynamic> json) => new Task(
    json['title'] as String,
    json['taskState'] == null
        ? null
        : TaskState.values.singleWhere(
            (x) => x.toString() == 'TaskState.${json['taskState']}'),
    json['id'] as String);

abstract class _$TaskSerializerMixin {
  String get id;
  String get title;
  TaskState get taskState;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'taskState':
            taskState == null ? null : taskState.toString().split('.')[1]
      };
}
