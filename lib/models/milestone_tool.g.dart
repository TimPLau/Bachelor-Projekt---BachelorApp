// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => new Milestone(
    json['title'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['id'] as String,
    json['tasks'] == null
        ? null
        : new Map<String, Task>.fromIterables(
            (json['tasks'] as Map<String, dynamic>).keys,
            (json['tasks'] as Map).values.map((e) => e == null
                ? null
                : new Task.fromJson(e as Map<String, dynamic>))),
    json['description'] as String);

abstract class _$MilestoneSerializerMixin {
  String get id;
  String get title;
  String get description;
  DateTime get date;
  Map<String, Task> get tasks;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'date': date?.toIso8601String(),
        'tasks': tasks
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
