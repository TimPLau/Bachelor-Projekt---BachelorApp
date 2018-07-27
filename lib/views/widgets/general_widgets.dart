import 'package:flutter/material.dart';

Flexible buildDescriptionContainer(String heading, List<String> information) {
  return Expanded(
    child: Container(
      child: ListView.builder(
          itemCount: information.length,
          itemBuilder: (context, index) {
            return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      heading,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    new Text(
                      information[index],
                    )
                  ],
                )
              ],
            );
          }),
    ),
  );
}

Container buildHeading(String heading) {
  return new Container(
    padding: EdgeInsets.only(bottom: 20.0),
    child: new Text(
      heading,
      softWrap: true,
      style: TextStyle(
          decorationStyle: TextDecorationStyle.dashed,
          fontStyle: FontStyle.normal,
          fontSize: 20.0),
    ),
  );
}
