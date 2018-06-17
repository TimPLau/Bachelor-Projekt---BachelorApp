import 'package:project_bachelorapplication/reducers/menu_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

AppState appReducer(AppState state, action){
  //print(state.toString());
  return new AppState(
      updateScreenTitle(state.actualScreenTitle, action),
      updatePreviousContent(state.previousContent, action),
      updateActualContent(state.actualContent, action)
    );

}