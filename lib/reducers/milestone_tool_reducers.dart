import 'dart:collection';



import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';

import 'package:project_bachelorapplication/models/milestone_tool.dart';

import 'package:uuid/uuid.dart';



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



updateSelectedMilestone(Milestone current, action){

  if(action is UpdateSelectedMilestone) {

    current = action.milestone;

    return current;

  }

}



Uuid generator = new Uuid();

Map<String, Milestone> updateMilestones (Map<String, Milestone> current, action){

  Map<String, Milestone> ret = new SplayTreeMap<String, Milestone>();



  if(action is AddMilestoneAction) {

    current[action.date.toIso8601String()] = new Milestone(action.title, action.date, action.date.toIso8601String(), {});



    ret.addAll(current);

    return ret;

  }



  if(action is AddTaskAction) {

    Map<String, Task> newTasks = action.milestone.tasks;

    String taskId = generator.v1();

    newTasks[taskId] = new Task(action.taskTitle, TaskState.notCompleted, taskId);



    current[action.milestone.id] = new Milestone(action.milestone.title, action.milestone.date, action.milestone.date.toIso8601String(), newTasks);



    return current;

  }



  if(action is RemoveMilestoneAction) {

    current.remove(action.milestone.id);

    return current;

  }



  if(action is RemoveTaskAction) {

    Map<String, Task> newTasks = action.milestone.tasks;

    newTasks.remove(action.task.id);



    current[action.milestone.id] = new Milestone(action.milestone.title, action.milestone.date, action.milestone.id, newTasks);;



    return current;

  }



  if(action is EditMilestoneAction) {



    Milestone editedMilestone = new Milestone(action.newTitle, action.newDate, action.newDate.toIso8601String(), action.milestone.tasks, action.newDescription);

    current.remove(action.milestone.id);

    current[editedMilestone.id] = editedMilestone;



    return current;

  }



  if(action is EditTaskAction) {

    Task editedTask = new Task(action.editedTaskTitle, action.task.taskState, action.task.id);

    Map<String, Task> newTasks = action.milestone.tasks;

    newTasks[action.task.id] = editedTask;

    Milestone newMilestone = new Milestone(action.milestone.title, action.milestone.date, action.milestone.id, newTasks);

    current[action.milestone.id] = newMilestone;



    return current;

  }



  if(action is ChangeTaskStateAction) {

    Task editedTask = new Task(action.task.title, action.task.taskState == TaskState.completed ? TaskState.notCompleted : TaskState.completed, action.task.id);

    Map<String, Task> newTasks = action.milestone.tasks;

    newTasks[action.task.id] = editedTask;



    Milestone newMilestone = new Milestone(action.milestone.title, action.milestone.date, action.milestone.id, newTasks);

    current[action.milestone.id] = newMilestone;



    return current;

  }



  return current;

}