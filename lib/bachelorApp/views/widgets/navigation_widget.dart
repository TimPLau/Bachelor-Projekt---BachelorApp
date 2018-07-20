import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/inforrmantion_tool_actions.dart';

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
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName(''));
                }
            ),
            new ListTile(
                title: new Text("Meilensteinplanung"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/milestoneOverview');
                }
            ),
            new ListTile(
                title: new Text("Bachelorarbeit Guide"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/guide');
                }
            ),
            new ListTile(
                title: new Text("Herausforderungen"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/challenges');
                }
            ),
            new ListTile(
                title: new Text("Achievements"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/achievements');
                }
            ),
            new ListTile(
                title: new Text("Einstellungen"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/settings');
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

