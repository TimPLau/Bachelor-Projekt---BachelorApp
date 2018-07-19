import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

TaskManager updateTasks (TaskManager current, action){

  if(action is AddMilestoneAction) {
    current.addMilestone(action.milestone);
    return current;
  }

  return current;
}
