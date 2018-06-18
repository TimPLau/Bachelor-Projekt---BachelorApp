import 'dart:convert' as JSON;

class ContentBuilder {
  List<Content> _content = [];
  Content _initContent;

  ContentBuilder(jsonPath){
    _readContent(jsonPath);
  }

  get initContent{
    return this._initContent;
  }

  List<Content> get content{
    return this._content;
  }

  _readContent(String jsonPath){

    _initContent = new Content("", "initContent", "", []);
    List<dynamic> _jsonContent = JSON.jsonDecode(jsonPath);

    for(dynamic jsonContentModule in _jsonContent){
      Content content = new Content(
        jsonContentModule["type"],
        jsonContentModule["title"],
        jsonContentModule["description"],
        jsonContentModule["tags"],
      );

      content.subsections = _loadContent(jsonContentModule["subsections"], content);
      content.prevContent = _initContent;
      _initContent.subsections = [content];
      _content.add(initContent);
    }
  }

  List<Content> _loadContent(List<dynamic> subsections, Content prevContent){
    List<Content> ret = [];

    for(dynamic subsection in subsections){

      Content c = new Content(
        subsection["type"],
        subsection["title"],
        subsection["description"],
        subsection["tags"],
      );

      c.prevContent = prevContent;
      c.subsections = _loadContent(subsection["subsections"], c);
      ret.add(c);
    }

    return ret;
  }

  @override
  String toString() {
    String ret = "";

    for(Content  content in _content){
      ret = ret + content.toString();
    }

    return ret;
  }
}

class Content{
  String type;
  String title;
  String description;
  List tags;
  Content _prevContent;
  List <Content> _subsections = [];

  Content(this.type, this.title, this.description, this.tags);

  get subsections{
    return this._subsections;
  }

  set subsections(List<Content> content){
    this._subsections.addAll(content);
  }

  set prevContent(Content c) {
    this._prevContent = c;
  }

  Content get prevContent{
    return this._prevContent;
  }


  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description\nTags: $tags\n";

    for(Content subsection in _subsections){
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }
}


