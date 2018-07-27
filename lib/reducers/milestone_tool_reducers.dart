import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';

updateBeginDate(DateTime current, action){
  if(action is UpdateBeginDateAction)
    return action.begin;

  return current;
}

updateEndDate(DateTime current, action){
  if(action is UpdateEndDateAction)
    return action.end;


  return current;
}

Map<String, Milestone> updateMilestones (Map<String, Milestone> current, action){

  if(action is AddMilestoneAction) {
    current[action.milestone.id] = action.milestone;
    return current;
  }
  if(action is AddTaskAction) {
    current[action.milestone.id].addTask(action.task);
    return current;
  }
  if(action is RemoveMilestoneAction) {
    current.remove(action.milestone.id);
    return current;
  }
  if(action is RemoveTaskAction) {
    current[action.milestone.id].removeTask(action.task);
    return current;
  }
  if(action is EditMilestoneAction) {
    current[action.milestone.id].changeValues(action.newTitle, action.newDate, action.newDescription);
    return current;
  }
  if(action is EditTaskAction) {
    current[action.milestone.id].tasks[action.task.id].changeValues(action.editedTaskTitle);
    return current;
  }
  if(action is ChangeTaskStateAction) {
    current[action.milestone.id].tasks[action.task.id].changeState();
    return current;
  }

  return current;
}
