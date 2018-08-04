import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AppContentLoader {
  String httpRequest;

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
    List<JSONAppContentFile> informationToolFiles = await getFiles(httpRequest);

    for (JSONAppContentFile file in informationToolFiles) {
      await file.getJsonContent();
      saveDataOnDevice(file.jsonFileContent, file.name);
    }
  }

  List<JSONAppContentFile> parseFiles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<JSONAppContentFile>((json) => JSONAppContentFile.fromJson(json))
        .toList();
  }

  void saveDataOnDevice(String jsonContent, String fileName) async {
    await writeContent(jsonContent, fileName);
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
      return "Empty";
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
