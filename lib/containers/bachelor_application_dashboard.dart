import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/containers/bachelor_application_add_begin_end_date.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/presentation/bachelor_application_dashboard_screen.dart';
import 'package:redux/redux.dart';

class Dashboard extends StatelessWidget {
  Dashboard();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, context);
      },
      builder: (BuildContext context, _ViewModel vm) {
        flutterLocalNotificationsPlugin.onSelectNotification =
            (s) => onSelectAchievementNotification(s, context);

        if ((vm.beginDate == null) || (vm.endDate == null))
          return AddBeginEndDate();

        return DashboardScreen(
          vm.milestones,
          vm.selectedMilestone,
          vm.onAdd,
          vm.onEdit,
          vm.onChangeState,
          vm.onRemoveTask,
          vm.onRemoveMilestone,
          vm.onSelectedMilestone,
          vm.beginDate,
          vm.endDate,
        );
      },
    );
  }
}

class _ViewModel {
  final Map<String, Milestone> milestones;
  Map<String, Achievement> achievements;
  final Milestone selectedMilestone;
  final Function onAdd;
  final Function onEdit;
  final Function onChangeState;
  final Function onRemoveTask;
  final Function onRemoveMilestone;
  final Function addEditDate;
  final Function onSelectedMilestone;
  DateTime initialBeginDate;
  DateTime initialEndDate;
  final DateTime beginDate;
  final DateTime endDate;
  bool isEditing;

  _ViewModel(
      {this.milestones,
      this.achievements,
      this.selectedMilestone,
      this.onAdd,
      this.onEdit,
      this.onChangeState,
      this.onRemoveTask,
      this.onRemoveMilestone,
      this.addEditDate,
      this.onSelectedMilestone,
      this.beginDate,
      this.endDate}) {
  }

  factory _ViewModel.fromStore(Store<AppState> store, BuildContext context) {
    return _ViewModel(
      milestones: store.state.currentMilestones,
      selectedMilestone: store.state.selectedMilestone,
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
      addEditDate: (DateTime begin, DateTime end) {
        store.dispatch(UpdateBeginDateAction(begin));
        store.dispatch(UpdateEndDateAction(end));
      },
      onSelectedMilestone: (Milestone milestone) =>
          store.dispatch(new UpdateSelectedMilestone(milestone)),
      beginDate: store.state.begin,
      endDate: store.state.end,
    );
  }
}
