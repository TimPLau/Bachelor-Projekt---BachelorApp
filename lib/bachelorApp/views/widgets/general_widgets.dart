import 'package:flutter/material.dart';

Container buildDescriptionContainer(String heading, String description) {
  return new Container(
    child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Text(
                heading,
                softWrap: true,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Text(
                description,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
