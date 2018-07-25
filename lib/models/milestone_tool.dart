import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

final Uuid idGenerator = new Uuid();

/*
class TaskManager {
  Map<String, Milestone> milestones = new Map<String, Milestone>();

  TaskManager();

  addMilestone(Milestone milestone) {
    this.milestones[milestone.id] = milestone;
  }

  removeMilestone(Milestone milestone) {
    this.milestones.remove(milestone.id);
  }

  List<String> getMilestoneDates() {
    List<String> retDates = [];

    for (Milestone m in this.milestones.values) {
      retDates.add(m.date.toIso8601String());
    }

    return retDates;
  }
}
*/

class Milestone {
  String id;
  String title;
  String description;
  DateTime date;
  Map<String, Task> tasks = new Map<String, Task>();

  Milestone(this.title, this.date, [this.description = ""]) {
    this.id = idGenerator.v1();
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

  List<Task> getCompletedTasks() {
    List<Task> ret = [];

    for (Task task in this.tasks.values.toList()) {
      if (task.taskState == TaskState.completed) ret.add(task);
    }

    return ret;
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
