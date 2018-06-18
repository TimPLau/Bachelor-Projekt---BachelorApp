import 'package:project_bachelorapplication/bachelorApp/reducers/content_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/menuactions.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
      updatePreviousContent(state.previousContent, action),
      updateActualContent(state.actualContent, action)
  );

}