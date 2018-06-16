import 'package:project_bachelorapplication/reducers/menu_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

AppState appReducer(AppState state, action){

  if(action is UpdateScreenTitleAction)
  return new AppState(
      updateScreenTitle(state.actualScreenTitle, action),
      state.actualPath,
      state.actualContent
  );

  if(action is UpdateScreenPathAction)
    return new AppState(
        state.actualScreenTitle,
        updateScreenPath(state.actualPath, action),
        state.actualContent
    );

  if(action is UpdateScreenContentAction)
    return new AppState(
        state.actualScreenTitle,
        state.actualPath,
        updateScreenContent(state.actualContent, action)
    );

  return state;
}