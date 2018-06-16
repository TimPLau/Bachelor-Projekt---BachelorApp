import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';

class AppState {
  String actualScreenTitle;
  String actualPath;
  List<Content> actualContent;

  AppState(this.actualScreenTitle, this.actualPath, this.actualContent);

}