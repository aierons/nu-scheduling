class InviteInfo {
  var title;
  var name;
  var location;
  var date;

  InviteInfo(this.title, this.name, this.location, this.date);

  String get getTitle {
    return this.title;
  }

  String get getName {
    return this.name;
  }

  String get getLoc {
    return this.location;
  }

  String get getDate {
    return this.date;
  }

  void setDate(String date) {
    this.date = date;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setName(String name) {
    this.name = name;
  }

  void setLoc(String s) {
    this.location = s;
  }
}