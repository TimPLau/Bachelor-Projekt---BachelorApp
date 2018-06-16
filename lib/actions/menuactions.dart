import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';

class UpdateScreenTitleAction{
  String screenTitle;

  UpdateScreenTitleAction(this.screenTitle);
}

class UpdateScreenPathAction{
  String screenPath;

  UpdateScreenPathAction(this.screenPath);
}

class UpdateScreenContentAction{
  List<Content> screenContent;

  UpdateScreenContentAction(this.screenContent);
}