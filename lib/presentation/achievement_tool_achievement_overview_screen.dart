import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/presentation/achievement_tool_achievement_details_overview_screen.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class AchievementOverviewScreen extends StatelessWidget {
  final Map<AchievementType, List<Achievement>> achievements;

  AchievementOverviewScreen(this.achievements);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigatorWidget(),
      //bottomNavigationBar: NavigatorWidget(),
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text("Deine Achievements"),
      ),
      body: new ListView.builder(
        itemCount: this.achievements.keys.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: new Text(getTitle(this.achievements.keys.toList()[index]),
              softWrap: true,
            ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AchievementDetailsOverviewScreen(this.achievements.values.toList()[index])));
              });

        },
      ),
    );
  }

  String getTitle(AchievementType type){

      switch(type){
        case AchievementType.prePhase: return "Vorbereitungsphase"; break;
        case AchievementType.beginningPhase: return "Anfangsphase"; break;
        case AchievementType.processingPhase: return "Bearbeitungsphase"; break;
        case AchievementType.conclusionPhase: return "Abschlussphase"; break;
        case AchievementType.special: return "App-Achievements"; break;
        default: break;
      }
    }
}
