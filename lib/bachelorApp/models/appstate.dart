import 'package:project_bachelorapplication/bachelorApp/models/content.dart';

class AppState {
  Content informationToolContent;

  AppState(this.informationToolContent);

  @override
  String toString() {
    return this.informationToolContent.title;
  }

}