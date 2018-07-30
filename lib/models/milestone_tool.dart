import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:uuid/uuid.dart';

part 'milestone_tool.g.dart';
final Uuid idGenerator = new Uuid();

@JsonSerializable()
class Milestone extends Object with _$MilestoneSerializerMixin{
  String id;
  String title;
  String description;
  DateTime date;
  Map<String, Task> tasks = new Map<String, Task>();

  Milestone(this.title, this.date, [this.description = ""]) {
    this.id = date.toIso8601String();
  }

  Map<String, Task> getCompletedTasks() {
    Map<String, Task> ret = {};

    tasks.forEach((key, value) {
      value.isCompleted() ? ret[key] = value : null;
    });

    return ret;
  }

  Map<String, Task> getNotCompletedTasks() {
    Map<String, Task> ret = {};

    tasks.forEach((key, value) {
      !value.isCompleted() ? ret[key] = value : null;
    });

    return ret;
  }

  addTask(Task task) {
    this.tasks[task.id] = task;
  }

  changeValues(String title, DateTime date, [String description]) {
    this.title = title;
    this.date = date;
    this.description = description;
  }

  removeTask(Task subTask) {
    this.tasks.remove(subTask.id);
  }

  Color getColorState() {
    if (this.tasks.isEmpty)
      return Colors.grey;
    else if (this.tasks.isNotEmpty && this.getNotCompletedTasks().isEmpty)
      return Colors.green;
    else if (this.tasks.isNotEmpty && this.date.isBefore(DateTime.now()))
      return Colors.red;
    else
      return Colors.amber;
  }

  factory Milestone.fromJson(Map<String, dynamic> json) => _$MilestoneFromJson(json);

  //Map<String, dynamic>  toJson() => {'id' : id, 'title' : title, 'description' : description, 'date' : date, 'tasks' : tasks};
}

@JsonSerializable()
class Task extends Object with _$TaskSerializerMixin{
  String id;
  String title;
  TaskState taskState;

  Task(this.title, this.taskState) {
    this.id = idGenerator.v1();
  }

  changeValues(String title) {
    this.title = title;
  }

  TaskState changeState() {
    return (this.taskState == TaskState.completed)
        ? this.taskState = TaskState.notCompleted
        : this.taskState = TaskState.completed;
  }

  bool isCompleted() {
    return (taskState == TaskState.completed) ? true : false;
  }

  //Map<String, dynamic>  toJson() => {'id' : id, 'title' : title, 'taskState' : taskState};

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

enum TaskState {
  completed,
  notCompleted,
}
