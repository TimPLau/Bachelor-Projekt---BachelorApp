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
  if(action is AddSubTaskAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].addSubTask(action.subTask);
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
  if(action is RemoveSubTaskAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].removeSubTask(action.subTask);
    return current;
  }
  if(action is EditMilestoneAction) {
    current.milestones[action.milestone.id].changeValues(action.milestone.title, action.milestone.description);
    return current;
  }
  if(action is EditTaskAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].changeValues(action.task.title, action.task.description);
    return current;
  }
  if(action is EditSubTaskAction) {
    //print(current.milestones[action.milestone.id].tasks[action.task.id].tasks[action.task.tasks.indexOf(action.subTask)]);

    current.milestones[action.milestone.id].tasks[action.task.id].subTasks[action.subTask.id].changeValues(action.editedSubTaskTitle);
    return current;
  }
  if(action is ChangeStateAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].subTasks[action.subTask.id].changeState();
    return current;
  }


  return current;
}
