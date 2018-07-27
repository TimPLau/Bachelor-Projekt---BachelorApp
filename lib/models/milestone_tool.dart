import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:uuid/uuid.dart';

final Uuid idGenerator = new Uuid();

class Milestone {
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
      return Colors.yellow;
  }
}

class Task {
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
}

enum TaskState {
  completed,
  notCompleted,
}
