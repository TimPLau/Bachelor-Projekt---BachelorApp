import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';

class AppContentLoader {
  String httpRequest;
  List<JSONAppContentFile> _jsonFiles = new List<JSONAppContentFile>();

  AppContentLoader(this.httpRequest);

  Future<List<JSONAppContentFile>> getFiles(String repositoryRequest) async {
    final response = await http.get(repositoryRequest);

    if (response.statusCode == 200) {
      return parseFiles(response.body);
    } else {
      throw Exception('Failed to load data\nMax requests per hour: ' +
          response.headers["x-ratelimit-limit"] +
          '\nRequests left: ' +
          response.headers["x-ratelimit-remaining"]);
    }
  }

  loadDataFromInternet() async {
    this._jsonFiles = await getFiles(httpRequest);
  }

  List<JSONAppContentFile> parseFiles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<JSONAppContentFile>((json) => JSONAppContentFile.fromJson(json))
        .toList();
  }

  void saveDataOnDevice() async {
    for (JSONAppContentFile file in this._jsonFiles) {
      await writeContent(await file.getJsonContent(), file.name);
    }

  }

  Future<File> writeContent(String jsonContent, String fileName) async {
    final file = await getLocalFile(fileName);
    return file.writeAsString('$jsonContent');
  }

  Future<String> readFile(String fileName) async {
    try {
      final file = await getLocalFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> getLocalFile(String fileName) async {
    final path = await getLocalPath();
    return File('$path/$fileName');
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> getFileContent(String fileName) async {
    return await readFile(fileName);
  }

  Future<Map<String, Content>> generateContent(String jsonFile) async {
    String fileContent = await getFileContent(jsonFile);
    Content initContent = new Content("INIT_ID", "", "INIT", "", []);
    Map<String, Content> ret = {initContent.id : initContent};

    if(fileContent != null) {
      for (dynamic jsonContentModule in json.decode(fileContent)) {

        Content c = new Content(
            jsonContentModule["id"],
            jsonContentModule["type"],
            jsonContentModule["title"],
            jsonContentModule["description"],
            jsonContentModule["subsections"].cast<String>()
        );

        if(jsonContentModule["id"].toString().contains("ROOT_"))
          initContent.subsections.add(c.id);

        ret[c.id] = c;
      }
    }
    return ret;
  }

}

class JSONAppContentFile {
  final String name;
  final String downloadUrl;
  String jsonFileContent;

  JSONAppContentFile({this.name, this.downloadUrl});

  factory JSONAppContentFile.fromJson(Map<String, dynamic> json) {
    return JSONAppContentFile(
      name: json['name'],
      downloadUrl: json['download_url'],
    );
  }

  Future<String> getJsonContent() async {
    http.Response response;

    response = await http.get(this.downloadUrl);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data\nMax requests per hour: ' +
          response.headers["x-ratelimit-limit"] +
          '\n' +
          '\nRequests left: ' +
          response.headers["x-ratelimit-remaining"]);
    }
  }
}
