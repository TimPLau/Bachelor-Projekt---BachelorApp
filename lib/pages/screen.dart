import 'package:project_bachelorapplication/models/content.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_widget.dart';

class Screen extends StatelessWidget{
  //List<Content> contentSections;
  String title;
  List<Content> content;

  Screen(this.title, this.content);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text(this.title),
        ),
        body: new Container(
            child: new Column(
                children: <Widget>[
                  new Flexible(
                    child: new ContentWidget(content),
                  ),
                ]
            )
        )
    );
  }

}