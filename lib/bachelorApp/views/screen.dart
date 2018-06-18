import 'package:project_bachelorapplication/bachelorApp/models/content.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp//views/containers/content_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/menuactions.dart';

class Screen extends StatelessWidget{
  String title;

  Screen(this.title);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
        return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.red,
              title: new Text(this.title),
              leading: new IconButton(
              onPressed: () {
                if (StoreProvider
                    .of<AppState>(context)
                    .state
                    .previousContent
                     != null) {
                  StoreProvider.of<AppState>(context).dispatch(
                      new UpdateActualContentAction(StoreProvider
                          .of<AppState>(context)
                          .state
                          .previousContent));

                StoreProvider.of<AppState>(context).dispatch(
                    new UpdatePreviousContentAction(StoreProvider
                        .of<AppState>(context)
                        .state
                        .previousContent
                        .prevContent));
                }
              },
              icon: new Icon(Icons.arrow_back)),
            ),
            body: new Container(
                child: new Column(
                    children: <Widget>[
                      new Flexible(
                        child: new ContentWidget(),
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
  final Content actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(actualContent: store.state.actualContent);
  }

}