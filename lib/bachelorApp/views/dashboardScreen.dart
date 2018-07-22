import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  final String title;

  DashboardScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
        return new Scaffold(
            drawer: NavigatorWidget(),
            //bottomNavigationBar: NavigatorWidget(),
            appBar: new AppBar(
              backgroundColor: Colors.red,
              title: new Text(this.title),
            ),
            body: new Container(child: new Column(children: <Widget>[])));
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel {
  final String actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(actualContent: "");
  }
}
