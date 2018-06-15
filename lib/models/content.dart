class ContentManager{
  List<Content> _content;

  ContentManager(){
    _content = <Content>[];
  }

  List<Content> get content{
    return this._content;
  }

  void addContent(Content contentModule){
    _content.add(contentModule);
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
  List <Content> subsections;

  Content(this.type, this.title, this.description, this.tags, this.subsections);

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description\nTags: $tags\n";

    for(Content subsection in subsections){
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }
}


