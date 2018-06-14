import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

class ContentListWidget extends StatelessWidget{
  List<ContentModule> contentModules;

  ContentListWidget(this.contentModules);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(new FillMenuAction(contentModules));
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm){
        return new Expanded(child: ListView.builder(
            itemCount: vm.list.length,
            itemBuilder: (context, index) => new ListTile(
              title: new Text(vm.list[index].title),
            )
        ),
        );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel{
  final List<ContentModule> list;

  _ViewModel({
    @required this.list,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(list: store.state.menu);
  }

}