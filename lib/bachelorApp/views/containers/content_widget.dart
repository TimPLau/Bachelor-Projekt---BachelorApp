import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/inforrmantion_tool_actions.dart';

class ContentWidget extends StatelessWidget{

  ContentWidget();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
         List<Content> content = StoreProvider.of<AppState>(context).state.informationToolContent.subsections;

         return new ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              if(content[index].type == "ButtonListWidget") {
                return new ListTile(
                    title: new Text(content[index].title),
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(new UpdateActualContentAction(content[index]));
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
  final String actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(actualContent: "");
  }

}