import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

class AddMilestoneAction {
  Milestone milestone;

  AddMilestoneAction(this.milestone);
}

class AddTaskAction {
  Milestone milestone;
  Task task;

  AddTaskAction(this.milestone, this.task);
}

class AddSubTaskAction {
  Milestone milestone;
  Task task;
  Task subTask;

  AddSubTaskAction(this.milestone, this.task, this.subTask);
}

class ChangeStateAction {
  Milestone milestone;
  Task task;
  Task subTask;

  ChangeStateAction(this.milestone, this.task, this.subTask);
}
