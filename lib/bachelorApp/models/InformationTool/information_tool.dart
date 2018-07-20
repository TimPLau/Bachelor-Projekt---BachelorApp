import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class InformationToolManager {
  Content _initContent;
  String informationToolPath;

  InformationToolManager(String informationToolPath) {
    this.informationToolPath = informationToolPath;
  }

  void init(String fileName) async{
    await loadDataFromInternet(fileName);
    await loadLocalFile(fileName);
  }

  loadDataFromInternet(String fileName) async {
    List<JSONInformationToolFile> informationToolFiles =
        await getFiles(informationToolPath);

    List<JSONInformationToolFileContent> informationToolFileContents = [];
    for(JSONInformationToolFile file in informationToolFiles) {
      informationToolFileContents.add(await file.getContent());
    }
    saveDataOnDevice(
        await mergeJsonFilesContent(informationToolFileContents), fileName);
  }

  Future<String> mergeJsonFilesContent(
      List<JSONInformationToolFileContent> content) async {
    int actualIndex = 1;
    String ret = "[\n";
    for (JSONInformationToolFileContent infToolFileContent in content) {
      ret += infToolFileContent.content +
          ((content.length != actualIndex) ? "," : "");
      actualIndex++;
    }
    return ret += "\n]";
    ;
  }

  loadLocalFile(String fileName) async {
    String content = await readFile(fileName);
    await _readContent(content);
  }

  Content get initContent {
    return this._initContent;
  }

  _readContent(String jsonFile) {
    _initContent = new Content("", "initContent", "");
    List<dynamic> _jsonContent = json.decode(jsonFile);

    for (dynamic jsonContentModule in _jsonContent) {
      Content content = new Content(
        jsonContentModule["type"],
        jsonContentModule["title"],
        jsonContentModule["description"],
      );

      content.subsections =
          _loadContent(jsonContentModule["subsections"], content);
      content.parentContent = _initContent;

      _initContent.subsections = [content];
    }
  }

  List<Content> _loadContent(List<dynamic> subsections, Content parentContent) {
    List<Content> ret = [];

    for (dynamic subsection in subsections) {
      Content content = new Content(
        subsection["type"],
        subsection["title"],
        subsection["description"],
      );

      content.parentContent = parentContent;
      content.subsections = _loadContent(subsection["subsections"], content);
      ret.add(content);
    }

    return ret;
  }

  @override
  String toString() {
    return _initContent.toString();
  }
}

class JSONInformationToolFile {
  final String name;
  final String url;
  JSONInformationToolFileContent jsonInformationToolFileContent;

  JSONInformationToolFile({this.name, this.url});

  factory JSONInformationToolFile.fromJson(Map<String, dynamic> json) {
    return JSONInformationToolFile(
      name: json['name'],
      url: json['url'],
    );
  }

  JSONInformationToolFileContent parseFileInformation(String responseBody) {
    Map<String, dynamic> parsed = json.decode(responseBody);
    var base64d = BASE64.decode(parsed["content"].replaceAll("\n", ""));
    var clearJson = LATIN1.decode(base64d);
    return new JSONInformationToolFileContent(
        clearJson.substring(clearJson.indexOf("{")));
  }

  Future<JSONInformationToolFileContent> getContent() async {
    http.Response response;

    response = await http.get(this.url);

    print(parseFileInformation(response.body));

    if (response.statusCode == 200) {
      this.jsonInformationToolFileContent = parseFileInformation(response.body);
      return this.jsonInformationToolFileContent;
    } else {
      throw Exception('Failed to load data\nMax requests per hour: ' +
          response.headers["x-ratelimit-limit"] +
          '\n' +
          '\nRequests left: ' +
          response.headers["x-ratelimit-remaining"]);
    }
  }
}

class JSONInformationToolFileContent {
  final String _content;

  JSONInformationToolFileContent(this._content);

  String get content {
    return _content;
  }
}

List<JSONInformationToolFile> parseFiles(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<JSONInformationToolFile>(
          (json) => JSONInformationToolFile.fromJson(json))
      .toList();
}

Future<List<JSONInformationToolFile>> getFiles(String repositoryRequest) async {
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

class Content {
  String type;
  String title;
  String description;
  Content _parentContent;
  List<Content> _subsections = [];

  Content(this.type, this.title, this.description);

  get subsections {
    return this._subsections;
  }

  set subsections(List<Content> content) {
    this._subsections.addAll(content);
  }

  set parentContent(Content c) {
    this._parentContent = c;
  }

  Content get parentContent {
    return this._parentContent;
  }

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description";

    for (Content subsection in _subsections) {
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }
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
  final path = await _localPath;
  return File('$path/$fileName');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
