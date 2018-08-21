import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:meta/meta.dart';

import 'package:project_bachelorapplication/models/achievement_tool.dart';

import 'package:uuid/uuid.dart';

part 'milestone_tool.g.dart';

final Uuid idGenerator = new Uuid();

@immutable
@JsonSerializable()
class Milestone extends Object with _$MilestoneSerializerMixin {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Map<String, Task> tasks;

  Milestone(this.title, this.date, this.id, this.tasks,
      [this.description = ""]);

  Map<String, Task> getCompletedTasks() {
    Map<String, Task> ret = {};

    tasks.forEach((key, value) {
      value.taskState == TaskState.completed ? ret[key] = value : null;
    });

    return ret;
  }

  Map<String, Task> getNotCompletedTasks() {
    Map<String, Task> ret = {};

    tasks.forEach((key, value) {
      value.taskState == TaskState.notCompleted ? ret[key] = value : null;
    });

    return ret;
  }

  MilestoneState getMilestoneState() {
    if (this.tasks.isEmpty)
      return MilestoneState.empty;
    else if (this.tasks.isNotEmpty && this.getNotCompletedTasks().isEmpty)
      return MilestoneState.allTasksCompleted;
    else if (this.tasks.isNotEmpty && this.date.isBefore(DateTime.now()))
      return MilestoneState.outOfDateAndSomeTasksNotCompleted;
    else
      return MilestoneState.someTasksNotCompleted;
  }

  factory Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);

//Map<String, dynamic>  toJson() => {'id' : id, 'title' : title, 'description' : description, 'date' : date, 'tasks' : tasks};

}

enum MilestoneState {
  empty,
  allTasksCompleted,
  someTasksNotCompleted,
  outOfDateAndSomeTasksNotCompleted
}

@immutable
@JsonSerializable()
class Task extends Object with _$TaskSerializerMixin {
  final String id;
  final String title;
  final TaskState taskState;

  Task(this.title, this.taskState, this.id);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

enum TaskState {
  completed,
  notCompleted,
}
