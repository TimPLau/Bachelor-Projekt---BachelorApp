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
  if(action is ChangeStateAction) {
    current.milestones[action.milestone.id].tasks[action.task.id].tasks[action.task.tasks.indexOf(action.subTask)].changeState();
    return current;
  }

  return current;
}
