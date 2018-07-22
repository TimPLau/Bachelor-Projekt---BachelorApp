import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

TaskManager updateTasks (TaskManager current, action){

  if(action is AddMilestoneAction) {
    current.addMilestone(action.milestone);
    return current;
  }
  if(action is AddTaskAction) {
    current.milestones[action.milestone.id].addTask(action.task);
    return current;
  }
  if(action is RemoveMilestoneAction) {
    current.removeMilestone(action.milestone);
    return current;
  }
  if(action is RemoveTaskAction) {
    current.milestones[action.milestone.id].removeTask(action.task);
    return current;
  }
  if(action is EditMilestoneAction) {
    current.milestones[action.milestone.id].changeValues(action.newTitle, action.newDate, action.newDescription);
    return current;
  }
  if(action is EditTaskAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].changeValues(action.editedTaskTitle);
    return current;
  }
  if(action is ChangeTaskStateAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].changeState();
    return current;
  }

  return current;
}
