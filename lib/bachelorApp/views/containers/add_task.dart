import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/add_task_screen.dart';


class AddTask extends StatelessWidget {
  final Milestone milestone;

  AddTask(this.milestone);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, this.milestone);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AddTaskScreen(vm.actualMilestone, vm.addTask);
      },
    );
  }
}

class _ViewModel {
  final Milestone actualMilestone;
  final Function addTask;

  _ViewModel(
      {this.actualMilestone, this.addTask});

  factory _ViewModel.fromStore(
      Store<AppState> store, Milestone actualMilestone) {
    return _ViewModel(
        actualMilestone: actualMilestone,
        addTask: (String title, String description) => store.dispatch(new AddTaskAction(actualMilestone, new Task(title, TaskState.notCompleted, description)))
    );
  }
}