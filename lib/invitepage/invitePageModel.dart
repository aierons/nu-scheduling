import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './inviteinfo.dart';

class InvitePageModel extends ChangeNotifier {
  final List<InviteInfo> _invites = [
    new InviteInfo(
        "Snell Study",
        "Jeff",
        "Snell Library",
        DateTime.now(),
        TimeOfDay(hour: 13, minute: 0),
        TimeOfDay(hour: 14, minute: 0),
        ["intille.s@northeastern.edu",
          "jeff@husky.neu.edu",
          "frank@husky.neu.edu",
        "jim@husky.neu.edu"])
  ];

  final List<InviteInfo> _accepted = [];

  // Get the current invites
  UnmodifiableListView<InviteInfo> get invites =>
      UnmodifiableListView(_invites);
  int get numInv => _invites.length;
  UnmodifiableListView<InviteInfo> get accepted =>
      UnmodifiableListView(_accepted);

  // Add pending invitation
  void add(InviteInfo invite) {
    _invites.add(invite);
    notifyListeners();
  }

  // Remove invite from pending
  void remove(InviteInfo invite) {
    _invites.remove(invite);
    notifyListeners();
  }

  // Clear pending invites
  void clearPending() {
    _invites.clear();
    notifyListeners();
  }

  // Accept meeting invitation
  void accept(InviteInfo invite) {
    this.remove(invite);
    invite.addMember("You");
    _accepted.add(invite);
    print("Joined ${invite.getName}'s meeting");
    notifyListeners();
  }

  void removeAccepted(InviteInfo invite) {
    _accepted.remove(invite);
    notifyListeners();
  }

  // Replaces an accepted meeting invitation with a new one
  // in this.accepted
  void replaceAccepted(InviteInfo old, InviteInfo updated) {
    int oldIdx = _accepted.indexOf(old);
    this.removeAccepted(old);
    _accepted.insert(oldIdx, updated);
  }
}
