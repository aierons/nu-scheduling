import 'package:flutter/material.dart';

class InviteInfo {
  var title;
  var name;
  var location;
  var date;
  var invitees;
  var end;
  var start;

  InviteInfo(
      this.title,
      this.name,
      this.location,
      this.date,
      this.start,
      this.end,
      this.invitees);

  String get getTitle {
    return this.title;
  }

  String get getName {
    return this.name;
  }

  String get getLoc {
    return this.location;
  }

  DateTime get getDate {
    return this.date;
  }

  TimeOfDay get getStart {
    return this.start;
  }

  TimeOfDay get getEnd {
    return this.end;
  }

  List<String> get getInvitees {
    return this.invitees;
  }

  void setInvitees(List<String> invitees) {
    this.invitees = invitees;
}

  void setDate(DateTime date) {
    this.date = date;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setStart(TimeOfDay time) {
    this.start = time;
  }

  void setEnd(TimeOfDay time) {
    this.end = time;
  }

  void setName(String name) {
    this.name = name;
  }

  void setLoc(String s) {
    this.location = s;
  }

  void addMember(String name) {
    this.invitees.add(name);
  }
}