import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:redux/redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/views/presentation/bachelor_application_dashboard_screen.dart';
import 'package:project_bachelorapplication/views/presentation/dashboard_initial_date_screen.dart';
import 'package:redux/redux.dart';

class AddBeginEndDate extends StatelessWidget {
  AddBeginEndDate();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {

        return AddEditBeginEndDateScreen(vm.addEditDate, vm.initialBeginDate, vm.initialEndDate, false);

      },
    );
  }
}

class _ViewModel {
  final Function(DateTime, DateTime) addEditDate;
  DateTime initialBeginDate;
  DateTime initialEndDate;

  _ViewModel({this.addEditDate}){
    this.initialBeginDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    this.initialEndDate = DateTime(DateTime.now().year, DateTime.now().month+3, DateTime.now().day);
  }

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      addEditDate: (DateTime begin, DateTime end) {
        store.dispatch(UpdateBeginDateAction(begin));
        store.dispatch(UpdateEndDateAction(end));
      },
    );
  }
}
