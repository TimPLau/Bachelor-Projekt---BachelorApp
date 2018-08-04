import 'package:project_bachelorapplication/models/milestone_tool.dart';

class AddMilestoneAction {
  String title;
  String description;
  DateTime date;

  AddMilestoneAction(this.title, this.description, this.date);
}

class UpdateSelectedMilestone{
  Milestone milestone;

  UpdateSelectedMilestone(this.milestone);
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
  String taskTitle;

  AddTaskAction(this.milestone, this.taskTitle);
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

class UpdateBeginDateAction{
  DateTime begin;

  UpdateBeginDateAction(this.begin);
}

class UpdateEndDateAction{
  DateTime end;

  UpdateEndDateAction(this.end);
}


