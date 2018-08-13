import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class ContentGuideScreen extends StatelessWidget {
  final Content content;

  ContentGuideScreen(this.content);

  @override
  Widget build(BuildContext context) {
    List<Content> content = this.content.subsections;

    return new Scaffold(
        drawer: NavigatorWidget(),
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          leading: (this.content.title != "INIT"
              ? new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : null),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text(this.content.title == "INIT"
              ? "Bachelorarbeit Guide".toUpperCase()
              : this.content.title.toUpperCase()),
        ),
        body: new ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              if (content[index].type == "ButtonListWidget") {
                return new Container(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: new Card(
                    child: new ListTile(
                      title: new Text(
                        content[index].title,
                        softWrap: true,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentGuideScreen(content[index])));
                      },
                    ),
                  ),
                );
              }

              if (content[index].type == "ExtensionPanelWidget") {
                return new Container(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: new Card(
                    child: new ExpansionTile(
                      title: new Text(
                        content[index].title,
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
                                  content[index].description,
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
