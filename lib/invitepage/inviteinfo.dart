class InviteInfo {
  var title;
  var name;
  var location;

  InviteInfo(this.title, this.name, this.location);

  String get getTitle {
    return this.title;
  }

  set setTitle(String newTitle) {
    this.title = newTitle;
  }

  set setLoc(String newLoc) {
    this.location = newLoc;
  }

  set setName(String newName) {
    this.title = newName;
  }

  String get getName {
    return this.name;
  }

  String get getLoc {
    return this.location;
  }
}