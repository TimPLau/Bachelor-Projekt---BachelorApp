import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/content.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/menuactions.dart';

class NavigatorWidget extends StatelessWidget{

  NavigatorWidget();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
        return Drawer(
          child: new ListView(
          children: <Widget>[
            new ListTile(
                title: new Text("Dashboard"),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                }
            ),
            new ListTile(
                title: new Text("Bachelorarbeit Guide"),
                onTap: () {
                  Navigator.pushNamed(context, '/guide');
                }
            ),
          ],
        ),
        );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel{
  final String actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(actualContent: "");
  }

}

