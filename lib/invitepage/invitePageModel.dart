import 'dart:collection';
import 'package:flutter/cupertino.dart';
import './inviteinfo.dart';

class InvitePageModel extends ChangeNotifier {
  final List<InviteInfo> _invites = [
    new InviteInfo("Snell Study", "Jeff", "Snell Library")
  ];

  final List<InviteInfo> _accepted = [];

  // Get the current invites
  UnmodifiableListView<InviteInfo> get invites => UnmodifiableListView(_invites);
  int get numInv => _invites.length;
  UnmodifiableListView<InviteInfo> get accepted => UnmodifiableListView(_accepted);

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
    _accepted.add(invite);
    print("Joined ${invite.getName}'s meeting");
    notifyListeners();
  }


}