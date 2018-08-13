import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:redux/redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/presentation/dashboard_initial_date_screen.dart';
import 'package:redux/redux.dart';

class EditBeginEndDate extends StatelessWidget {
  EditBeginEndDate();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AddEditBeginEndDateScreen(vm.addEditDate, vm.initialBeginDate,
            vm.initialEndDate, true, vm.begin, vm.end);
      },
    );
  }
}

class _ViewModel {
  final Function(DateTime, DateTime) addEditDate;
  DateTime initialBeginDate;
  DateTime initialEndDate;
  final DateTime begin;
  final DateTime end;

  _ViewModel({this.addEditDate, this.begin, this.end}) {
    this.initialBeginDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    this.initialEndDate = DateTime(
        DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  }

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      begin: store.state.begin,
      end: store.state.end,
      addEditDate: (DateTime begin, DateTime end) {
        store.dispatch(UpdateBeginDateAction(begin));
        store.dispatch(UpdateEndDateAction(end));
      },
    );
  }
}
