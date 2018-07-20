import 'package:flutter/material.dart';

Container buildDescriptionContainer(String heading, String description) {
  return new Container(
    child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              child: new Text(
                heading,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Container(
              child: new Text(
                description,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
