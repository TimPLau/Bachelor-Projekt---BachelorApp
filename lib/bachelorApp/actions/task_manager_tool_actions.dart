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

  EditMilestoneAction(this.milestone);
}

class AddTaskAction {
  Milestone milestone;
  Task task;

  AddTaskAction(this.milestone, this.task);
}

class EditTaskAction {
  Milestone milestone;
  Task task;

  EditTaskAction(this.milestone, this.task);
}

class RemoveTaskAction {
  Milestone milestone;
  Task task;

  RemoveTaskAction(this.milestone, this.task);
}

class AddSubTaskAction {
  Milestone milestone;
  Task task;
  Task subTask;

  AddSubTaskAction(this.milestone, this.task, this.subTask);
}

class EditSubTaskAction {
  Milestone milestone;
  Task task;
  Task subTask;
  String editedSubTaskTitle;
  String editedSubTaskDescription;

  EditSubTaskAction(this.milestone, this.task, this.subTask, this.editedSubTaskTitle, [this.editedSubTaskDescription]);
}

class RemoveSubTaskAction {
  Milestone milestone;
  Task task;
  Task subTask;

  RemoveSubTaskAction(this.milestone, this.task, this.subTask);
}

class ChangeStateAction {
  Milestone milestone;
  Task task;
  Task subTask;

  ChangeStateAction(this.milestone, this.task, this.subTask);
}


