import 'package:project_bachelorapplication/reducers/menu_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';

AppState appReducer(AppState state, action){
  return new AppState(
    menuReducer(state.actualContent, action)
  );
}