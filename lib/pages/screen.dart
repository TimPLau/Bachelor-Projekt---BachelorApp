import 'package:project_bachelorapplication/models/content.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

class Screen extends StatelessWidget{
  //List<Content> contentSections;
  String title;
  List<Content> content;
  String path;

  Screen(this.content, this.title);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
        this.path = StoreProvider.of<AppState>(context).state.actualPath;
        return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.red,
              title: new Text(this.title),
            ),
            body: new Container(
                child: new Column(
                    children: <Widget>[
                      new Flexible(
                        child: new ContentWidget(this.content),
                      ),
                    ]
                )
            )
        );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel{
  final String screen;

  _ViewModel({
    @required this.screen,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(screen: store.state.actualScreenTitle);
  }

}