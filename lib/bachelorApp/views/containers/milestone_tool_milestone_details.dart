import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/milestone_tool_milestone_detail_screen.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';

class MilestoneDetails extends StatelessWidget {
  final Milestone milestone;

  MilestoneDetails(this.milestone);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, this.milestone);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MilestoneDetailScreen(
          milestone: vm.actualMilestone,
          onAdd: vm.onAdd,
          onEdit: vm.onEdit,
          onChangeState: vm.onChangeState,
          onRemoveTask: vm.onRemoveTask,
          onRemoveMilestone: vm.onRemoveMilestone,
        );
      },
    );
  }
}

class _ViewModel {
  final Milestone actualMilestone;
  final Function onAdd;
  final Function onEdit;
  final Function onChangeState;
  final Function onRemoveTask;
  final Function onRemoveMilestone;

  _ViewModel(
      {this.actualMilestone, this.onAdd, this.onEdit, this.onChangeState, this.onRemoveTask, this.onRemoveMilestone});

  factory _ViewModel.fromStore(
      Store<AppState> store, Milestone actualMilestone) {
    return _ViewModel(
      actualMilestone: actualMilestone,
      onRemoveMilestone: () => store.dispatch(new RemoveMilestoneAction(actualMilestone)),
      onRemoveTask: (Task deleteTask) =>
          store.dispatch(new RemoveTaskAction(actualMilestone, deleteTask)),
      onAdd: (Task newTask) =>
          store.dispatch(new AddTaskAction(actualMilestone, newTask)),
      onEdit: (Task editTask, String newTitle) =>
          store.dispatch(new EditTaskAction(actualMilestone, editTask, newTitle)),
      onChangeState: (Task changedTask) =>
          store.dispatch(new ChangeTaskStateAction(actualMilestone, changedTask)),
    );
  }
}
