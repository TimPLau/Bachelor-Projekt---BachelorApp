import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class ContentGuideScreen extends StatelessWidget {
  final String currentContentID;
  final Map<String, Content> content;

  ContentGuideScreen(this.currentContentID, this.content);

  @override
  Widget build(BuildContext context) {
    Content currentContent = this.content[currentContentID];
    List<String> currentContentSubsections = currentContent.subsections;

    return new Scaffold(
        drawer: NavigatorWidget(),
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          leading: (currentContent.title != "INIT"
              ? new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : null),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text(currentContent.title == "INIT" ? "Bachelorarbeit Guide".toUpperCase() : currentContent.title),
        ),
        body: new ListView.builder(
            itemCount: currentContentSubsections.length,
            itemBuilder: (context, index) {

              if (this.content[currentContentSubsections[index]].type == "ButtonListWidget") {
                return new Container(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                  child: new Card(
                    child: new ListTile(
                      leading: Icon(Icons.chevron_right),
                      title: new Text(
                        this.content[currentContentSubsections[index]].title,
                        softWrap: true,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentGuideScreen(this.content[currentContentSubsections[index]].id , this.content)));
                      },
                    ),
                  ),
                );
              }

              if (this.content[currentContentSubsections[index]].type == "ExtensionPanelWidget") {
                return new Container(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                  child: new Card(
                    child: new ExpansionTile(
                      leading: Icon(Icons.info_outline),
                      title: new Text(
                        this.content[currentContentSubsections[index]].title,
                        softWrap: true,
                      ),
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.all(20.0),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new Text(
                                  this.content[currentContentSubsections[index]].description,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
