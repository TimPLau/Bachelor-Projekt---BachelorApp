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
                print("ButtonListWidget");

                return new ListTile(
                    title: new Text(content[index].title),
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(new UpdateScreenTitleAction(this.content[index].title));
                      StoreProvider.of<AppState>(context).dispatch(new UpdateScreenPathAction(this.content[index].path));
                      //StoreProvider.of<AppState>(context).dispatch(new UpdateScreenContentAction(this.content[index].subsections));
                      Navigator.of(context).pushNamed(this.content[index].path);
                      print(this.content[index].path);
                    }
                );
              }

              if(content[index].type == "ExtensionPanelWidget"){
                print("ExtensionPanelWidget");
                return new ExpansionTile(
                  title: new Text(content[index].title),
                  children: <Widget>[
                    new Text(content[index].description),
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