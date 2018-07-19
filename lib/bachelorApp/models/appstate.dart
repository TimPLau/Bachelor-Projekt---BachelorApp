import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

class AppState {
  Content informationToolContent;
  TaskManager taskManager;

  AppState(this.informationToolContent, this.taskManager);
}
