import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/task_detail_screen.dart';

class TaskDetails extends StatelessWidget {
  final Task task;
  final Milestone milestone;

  TaskDetails(this.milestone, this.task);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, this.milestone, this.task);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return TaskDetailScreen(
          task: vm.actualTask,
          onAdd: vm.onAdd,
          onEdit: vm.onEdit,
          onChangeState: vm.onChangeState,
          onRemove: vm.onRemove,
        );
      },
    );
  }
}

class _ViewModel {
  final Task actualTask;
  final Milestone actualMilestone;
  final Function onAdd;
  final Function onEdit;
  final Function onChangeState;
  final Function onRemove;

  _ViewModel(
      {this.actualTask, this.actualMilestone, this.onAdd, this.onEdit, this.onChangeState, this.onRemove});

  factory _ViewModel.fromStore(
      Store<AppState> store, Milestone actualMilestone, Task actualTask) {
    return _ViewModel(
      actualTask: actualTask,
      actualMilestone: actualMilestone,
      onRemove: (Task subTask) =>
          store.dispatch(new RemoveSubTaskAction(actualMilestone, actualTask, subTask)),
      onAdd: (Task subTask) =>
          store.dispatch(new AddSubTaskAction(actualMilestone, actualTask, subTask)),
      onEdit: (Task subTask, String newTitle) =>
          store.dispatch(new EditSubTaskAction(actualMilestone, actualTask, subTask, newTitle)),
      onChangeState: (Task subTask) =>
          store.dispatch(new ChangeStateAction(actualMilestone, actualTask, subTask)),
    );
  }
}
