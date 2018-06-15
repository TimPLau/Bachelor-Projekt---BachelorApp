import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

class ContentButtonListWidget extends StatelessWidget{
  List<Content> content;

  ContentButtonListWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
         return new ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) => new ListTile(
              title: new Text(content[index].title),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new Screen(this.content[index].title, this.content[index].subsections)));
              }
            )
        );

      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel{
  final List<Content> list;

  _ViewModel({
    @required this.list,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(list: store.state.actualContent);
  }

}