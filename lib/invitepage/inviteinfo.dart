class InviteInfo {
  final title;
  final name;
  final location;

  InviteInfo(this.title, this.name, this.location);

  String get getTitle {
    return this.title;
  }

  String get getName {
    return this.name;
  }

  String get getLoc {
    return this.location;
  }
}