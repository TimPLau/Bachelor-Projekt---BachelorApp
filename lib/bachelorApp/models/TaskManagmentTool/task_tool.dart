import 'package:uuid/uuid.dart';

final Uuid idGenerator = new Uuid();

class TaskManager {
  Map<String, Milestone> milestones = new Map<String, Milestone>();

  TaskManager();

  addMilestone(Milestone milestone) {
    this.milestones[milestone.id] = milestone;
  }

  removeMilestone(Milestone milestone) {
    this.milestones.remove(milestone);
  }
}

class Milestone {
  String id;
  String title;
  String description;
  DateTime date;
  Map<String, Task> tasks = new Map<String, Task>();

  Milestone(this.title, [this.description = ""]) {
    this.id = idGenerator.v1();
  }

  addTask(Task task) {
    this.tasks[task.id] = task;
  }

  changeValues(String title, [String description]) {
    this.title = title;
    this.description = description;
  }

  removeTask(Task task) {
    this.tasks.remove(task);
  }
}

class Task {
  String id;
  String title;
  String description;
  TaskState taskState;
  Map<String, Task> subTasks = new Map<String, Task>();

  Task(this.title, this.taskState, [this.description = ""]) {
    this.id = idGenerator.v1();
  }

  void addSubTask(Task task) {
    this.subTasks[task.id] = task;
  }

  changeValues(String title, [String description]) {
    this.title = title;
    this.description = description;
  }

  removeSubTask(Task subTask) {
    this.subTasks.remove(subTask.id);
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

enum Phase {
  initiation,
  planning,
  realizing,
  completion,
}

enum TaskState {
  completed,
  notCompleted,
}
