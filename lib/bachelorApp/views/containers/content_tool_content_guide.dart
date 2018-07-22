import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/content_tool_guide_screen.dart';
import 'package:redux/redux.dart';


class ContentGuide extends StatelessWidget {

  ContentGuide();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return new ContentGuideScreen(vm.content);
      },
    );
  }
}

class _ViewModel {
  final Content content;

  _ViewModel({this.content});

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      content: store.state.informationToolContent,
    );
  }

}