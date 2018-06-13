class ContentManager{
  List<ContentModule> _content;

  ContentManager(){
    _content = <ContentModule>[];
  }

  void addContentModule(ContentModule contentModule){
    _content.add(contentModule);
  }

  @override
  String toString() {
    String ret = "";

    for(ContentModule  contentModule in _content){
      ret = ret + contentModule.toString();
    }

    return ret;
  }
}

class ContentModule{
  String title;
  String description;
  List tags;
  List <ContentSection> subsections;

  ContentModule(this.title, this.description, this.tags, this.subsections);

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description\nTags: $tags\n";

    for(ContentSection contentSecion in subsections){
      ret = ret + "\n" + contentSecion.toString();
    }

    return ret;
  }
}

class ContentSection {
  String title;
  String description;
  List tags;
  List<ContentSection> subsections;

  int depth;

  ContentSection(this.title, this.description, this.tags, this.subsections);

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description\nTags: $tags\n";
    for(ContentSection contentSecion in subsections){
      ret = ret + contentSecion.toString();
    }

    return ret;
  }
}