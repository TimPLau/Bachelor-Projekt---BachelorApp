import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/presentation/milestone_tool_milestone_detail_screen.dart';
import 'package:redux/redux.dart';

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
      {this.actualMilestone,
      this.onAdd,
      this.onEdit,
      this.onChangeState,
      this.onRemoveTask,
      this.onRemoveMilestone});

  factory _ViewModel.fromStore(
      Store<AppState> store, Milestone actualMilestone) {
    return _ViewModel(
      actualMilestone: actualMilestone,
      onRemoveMilestone: (Milestone activeMilestone) =>
          store.dispatch(new RemoveMilestoneAction(activeMilestone)),
      onRemoveTask: (Task deleteTask, Milestone activeMilestone) =>
          store.dispatch(new RemoveTaskAction(activeMilestone, deleteTask)),
      onAdd: (String newTask, Milestone activeMilestone) =>
          store.dispatch(new AddTaskAction(activeMilestone, newTask)),
      onEdit: (Task editTask, String newTitle, Milestone activeMilestone) =>
          store.dispatch(
              new EditTaskAction(activeMilestone, editTask, newTitle)),
      onChangeState: (Task changedTask, Milestone activeMilestone) => store
          .dispatch(new ChangeTaskStateAction(activeMilestone, changedTask)),
    );
  }
}
