import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/views/presentation/bachelor_application_dashboard_screen.dart';
import 'package:redux/redux.dart';

class Dashboard extends StatelessWidget {
  Dashboard();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        flutterLocalNotificationsPlugin.onSelectNotification =
            (s) => onSelectNotification(s, context);

        return DashboardScreen(
            vm.milestones,
            vm.onAdd,
            vm.onEdit,
            vm.onChangeState,
            vm.onRemoveTask,
            vm.onRemoveMilestone
        );
      },
    );
  }
}

class _ViewModel {
  Map<String, Milestone> milestones;
  Map<String, Achievement> achievements;
  final Function onAdd;
  final Function onEdit;
  final Function onChangeState;
  final Function onRemoveTask;
  final Function onRemoveMilestone;

  _ViewModel({this.milestones, this.achievements, this.onAdd,
    this.onEdit,
    this.onChangeState,
    this.onRemoveTask,
    this.onRemoveMilestone}){}

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      milestones: store.state.currentMilestones,
      onRemoveMilestone: (Milestone activeMilestone) =>
          store.dispatch(new RemoveMilestoneAction(activeMilestone)),

      onRemoveTask: (Task deleteTask, Milestone activeMilestone) =>
          store.dispatch(new RemoveTaskAction(activeMilestone, deleteTask)),

      onAdd: (Task newTask, Milestone activeMilestone) =>
          store.dispatch(new AddTaskAction(activeMilestone, newTask)),

      onEdit: (Task editTask, String newTitle, Milestone activeMilestone) => store
          .dispatch(new EditTaskAction(activeMilestone, editTask, newTitle)),

      onChangeState: (Task changedTask, Milestone activeMilestone) => store
          .dispatch(new ChangeTaskStateAction(activeMilestone, changedTask)),
    );
  }
}
