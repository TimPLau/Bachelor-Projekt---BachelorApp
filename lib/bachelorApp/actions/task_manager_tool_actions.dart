import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

class AddMilestoneAction {
  Milestone milestone;

  AddMilestoneAction(this.milestone);
}

class RemoveMilestoneAction {
  Milestone milestone;

  RemoveMilestoneAction(this.milestone);
}

class EditMilestoneAction {
  Milestone milestone;
  String newTitle;
  DateTime newDate;
  String newDescription;

  EditMilestoneAction(this.milestone, this.newTitle, this.newDate, this.newDescription);
}

class AddTaskAction {
  Milestone milestone;
  Task task;

  AddTaskAction(this.milestone, this.task);
}

class RemoveTaskAction {
  Milestone milestone;
  Task task;

  RemoveTaskAction(this.milestone, this.task);
}

class EditTaskAction {
  Milestone milestone;
  Task task;
  String editedTaskTitle;

  EditTaskAction(this.milestone, this.task, this.editedTaskTitle);
}

class ChangeTaskStateAction {
  Milestone milestone;
  Task task;

  ChangeTaskStateAction(this.milestone, this.task);
}


