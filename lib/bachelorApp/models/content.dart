import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class InformationToolManager {
  //List<Content> _content = [];
  Content _initContent;
  List<InformationToolFile> informationToolFiles;
  List<InformationToolFileContent> informationToolFileContents;
  String informationToolPath;
  String localPath;
  File localFile;

  InformationToolManager(String informationToolPath){
    this.informationToolPath = informationToolPath;
  }

  void init(String fileName) async{
    loadDataFromInternet(fileName);
    await loadLocalFile(fileName);
  }

  loadDataFromInternet(String fileName) async{
    this.informationToolFiles = await getFiles(informationToolPath);
    this.informationToolFileContents = await getContent(informationToolFiles);

    saveDataOnDevice(await mergeJsonFilesContent(informationToolFileContents), fileName) ;
  }

  Future<String> mergeJsonFilesContent(List<InformationToolFileContent> content) async{
    int actualIndex = 1;
    String ret = "[\n";
    for(InformationToolFileContent infToolFileContent in content) {
      ret += infToolFileContent.content + ((content.length != actualIndex) ? "," : "");
      actualIndex++;
    }
    return ret += "\n]";;
  }

  loadLocalFile(String fileName) async{
    String content = await readFile(fileName);
    _readContent(content);
  }

  Content get initContent{
    return this._initContent;
  }

  _readContent(String jsonFile){

    _initContent = new Content("", "initContent", "");
    List<dynamic> _jsonContent = json.decode(jsonFile);

    for(dynamic jsonContentModule in _jsonContent){
      Content content = new Content(
        jsonContentModule["type"],
        jsonContentModule["title"],
        jsonContentModule["description"],
      );

      content.subsections = _loadContent(jsonContentModule["subsections"], content);
      content.parentContent = _initContent;

      _initContent.subsections = [content];
    }
  }

  List<Content> _loadContent(List<dynamic> subsections, Content parentContent){
    List<Content> ret = [];

    for(dynamic subsection in subsections){

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

class Content{
  String type;
  String title;
  String description;
  Content _parentContent;
  List <Content> _subsections = [];

  Content(this.type, this.title, this.description);

  get subsections{
    return this._subsections;
  }

  set subsections(List<Content> content){
    this._subsections.addAll(content);
  }

  set parentContent(Content c) {
    this._parentContent = c;
  }

  Content get parentContent{
    return this._parentContent;
  }

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description";

    for(Content subsection in _subsections){
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }
}

class InformationToolFile{
  final String name;
  final String url;

  InformationToolFile({this.name, this.url});

  factory InformationToolFile.fromJson(Map<String, dynamic> json){
    return InformationToolFile(
      name: json['name'],
      url:  json['url'],
    );
  }

}

class InformationToolFileContent{
  final String _content;

  InformationToolFileContent(this._content);

  String get content{
    return _content;
  }

}

void saveDataOnDevice(String jsonContent, String fileName) async{
  final file = await writeContent(jsonContent, fileName);
}

Future<File> writeContent(String jsonContent, String fileName) async {
  final file = await getLocalFile(fileName);

  // Write the file
  return file.writeAsString('$jsonContent');
}

Future<String> readFile(String fileName) async {
  try {
    final file = await getLocalFile(fileName);

    // Read the file
    return await file.readAsString();
  } catch (e) {
    // If we encounter an error, return 0
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

List<InformationToolFile> parseFiles(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<InformationToolFile>((json) => InformationToolFile.fromJson(json)).toList();
}

Future<List<InformationToolFile>> getFiles(String repositoryRequest) async{
  final response = await http.get(repositoryRequest);
  if(response.statusCode == 200) {
    return parseFiles(response.body);
  } else {
    throw Exception('Failed to load data\nMax requests per hour: ' + response.headers["x-ratelimit-limit"] + '\nRequests left: ' +  response.headers["x-ratelimit-remaining"]);
  }
}

InformationToolFileContent parseFileInformation(String responseBody) {
  Map<String, dynamic> parsed = json.decode(responseBody);
  var base64d = BASE64.decode(parsed["content"].replaceAll("\n", ""));
  var clearJson = LATIN1.decode(base64d);
  return new InformationToolFileContent(clearJson.substring(clearJson.indexOf("{")));
}

Future<List<InformationToolFileContent>> getContent(List<InformationToolFile> informationToolFiles) async{
  List<InformationToolFileContent> ret = [];
  http.Response response;

  for(InformationToolFile file in informationToolFiles){
    response = await http.get(file.url);
    ret.add(parseFileInformation(response.body));
  }

  if(response.statusCode == 200) {
    return ret;
  } else {
    throw Exception('Failed to load data\nMax requests per hour: ' + response.headers["x-ratelimit-limit"] + '\n' + '\nRequests left: ' + response.headers["x-ratelimit-remaining"]);
  }
}