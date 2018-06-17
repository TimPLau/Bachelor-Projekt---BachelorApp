import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

class ContentWidget extends StatelessWidget{
  List<Content> content;
  ContentWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
         return new ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {

              if(content[index].type == "ButtonListWidget") {
                return new ListTile(
                    title: new Text(content[index].title),
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(new UpdatePreviousContentAction(this.content[index].prevContent));
                      StoreProvider.of<AppState>(context).dispatch(new UpdateActualContentAction(this.content[index]));
                    }
                );
              }

              if(content[index].type == "ExtensionPanelWidget"){
                return new ExpansionTile(
                  title: new Text(content[index].title),
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: new Row(
                      children: <Widget>[new Text(content[index].description,textAlign: TextAlign.left, textDirection: TextDirection.ltr,)],
                    ),),
                  ],
                );
              }
            }

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