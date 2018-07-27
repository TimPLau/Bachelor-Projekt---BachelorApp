import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/views/containers/bachelor_application_add_begin_end_date.dart';
import 'package:project_bachelorapplication/views/presentation/bachelor_application_dashboard_screen.dart';
import 'package:project_bachelorapplication/views/presentation/dashboard_initial_date_screen.dart';
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

        if(!(vm.beginDate == null) && !(vm.endDate == null)) {
          print("BOBA " + vm.beginDate.toIso8601String());
          print("BOBA " + vm.endDate.toIso8601String());
        }
        if((vm.beginDate == null) || (vm.endDate == null)) return AddBeginEndDate();



        return DashboardScreen(
            vm.milestones,
            vm.onAdd,
            vm.onEdit,
            vm.onChangeState,
            vm.onRemoveTask,
            vm.onRemoveMilestone,
          vm.beginDate,
          vm.endDate,
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
  final Function addEditDate;
  DateTime initialBeginDate;
  DateTime initialEndDate;
  final DateTime beginDate;
  final DateTime endDate;
  bool isEditing;

  _ViewModel({this.milestones, this.achievements, this.onAdd,
    this.onEdit,
    this.onChangeState,
    this.onRemoveTask,
    this.onRemoveMilestone, this.addEditDate,this.beginDate, this.endDate}){

  }

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

      addEditDate: (DateTime begin, DateTime end) {
        store.dispatch(UpdateBeginDateAction(begin));
        store.dispatch(UpdateEndDateAction(end));
      },

      beginDate: store.state.begin,

      endDate: store.state.end,

    );
  }
}

