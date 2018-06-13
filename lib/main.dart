import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project_bachelorapplication/json_reader/json_reader.dart';
import 'package:project_bachelorapplication/content/content.dart';

final String path = 'assets/data/';
final String contentFilename = 'content.json';
String localPath;


Future<String> get _localPath async {
  return rootBundle.loadString(path + contentFilename);
}
  init()async{
    localPath = await _localPath;
  }

  void main() async{
    await init();
    JSONReader jsonReader = new JSONReader(localPath);

    print(jsonReader.contentManager.toString());
  }