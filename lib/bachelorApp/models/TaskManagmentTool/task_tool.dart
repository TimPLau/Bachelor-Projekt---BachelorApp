class TaskManager {
  Map<int, Milestone> milestones = new Map<int, Milestone>();

  TaskManager();

  addMilestone(Milestone milestone){
    this.milestones[milestones.length] = milestone;

    for(Milestone m in milestones.values)
      print(m.title);
  }

  removeMilestone(){

  }

}

class Milestone {
  String title;
  DateTime date;
  Map<int, Task> activeTasks;
  Map<int, Task> completedTasks;

  Milestone(this.title){
    this.activeTasks = new Map<int, Task>();
    this.completedTasks = new Map<int, Task>();
  }

}

class Task{
  String title;
  String description;
  TaskState taskState;
  List<Task> task;

  Task(this.title, this.description, this.taskState);

  TaskState changeState(){
      return (this.taskState == TaskState.completed) ? this.taskState = TaskState.completed : this.taskState = TaskState.notCompleted;
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
