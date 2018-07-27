import 'dart:convert';

class InformationToolContentBuilder {

  Content rootContent;

  InformationToolContentBuilder();

  generateContent(String jsonFile) {
    Content init = new Content("", "INIT", "", []);

    for (dynamic jsonContentModule in json.decode(jsonFile)) {
      Content content = new Content(
        jsonContentModule["type"],
        jsonContentModule["title"],
        jsonContentModule["description"],
        _loadInformation(jsonContentModule["subsections"]),
      );

      init.subsections = [content];
    }

    this.rootContent = init;

  }

  List<Content> _loadInformation(List<dynamic> subsections) {
    List<Content> ret = [];

    for (dynamic subsection in subsections) {
      Content content = new Content(
        subsection["type"],
        subsection["title"],
        subsection["description"],
        _loadInformation(subsection["subsections"]),
      );
      ret.add(content);
    }

    return ret;
  }
}

class Content {
  String type;
  String title;
  String description;
  List<Content> _subsections = [];

  Content(this.type, this.title, this.description, this._subsections);

  get subsections {
    return this._subsections;
  }

  set subsections(List<Content> content) {
    this._subsections.addAll(content);
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
