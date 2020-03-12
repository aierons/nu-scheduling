import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './invitepage/inviteinfo.dart';
import 'invitepage/InvitePageModel.dart';

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

// Separate page for changing a given meeting's location
// Takes in the current InvitePageModel as well as the meeting to change
class LocationSetup extends StatefulWidget {
  InviteInfo _invite;
  InvitePageModel _model;

  LocationSetup(InviteInfo invite, InvitePageModel model) {
    this._invite = invite;
    this._model = model;
  }

  @override
  _LocationSetup createState() => _LocationSetup(_invite, _model);
}

class _LocationSetup extends State<LocationSetup> {
  InviteInfo _invite;
  InvitePageModel _model;

  List<ListItem<String>> list = [
    ListItem<String>('Snell Library'),
    ListItem<String>('Curry Student Center'),
    ListItem<String>('Ryder Hall'),
    ListItem<String>('Richards Hall'),
  ];

  _LocationSetup(InviteInfo invite, InvitePageModel model) {
    this._invite = invite;
    this._model = model;

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Stack(
          children: <Widget>[
            Center(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: _getListItemTile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        var itemSelected =
            list.singleWhere((item) => item.isSelected, orElse: () => null);
        // if every single item is not selected, then allow for selection
        if (list.every((item) => !item.isSelected)) {
          setState(() {
            // allow selection
            list[index].isSelected = !list[index].isSelected;
          });
        } else if (itemSelected != null) {
          setState(() {
            itemSelected.isSelected = false;
            list[index].isSelected = !list[index].isSelected;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        color: list[index].isSelected ? Colors.red[100] : Colors.white,
        child: ListTile(
          title: Text(list[index].data),
          onTap: () {
            // Add new invite with updated location.
            // Mutation doesn't refresh widget tree.
            var newLoc = list[index].data;
            InviteInfo newInvite = new InviteInfo(_invite.title, _invite.getName, newLoc, _invite.getDate);
            _model.removeAccepted(_invite);
            _model.accept(newInvite);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        ),
      ),
    );
  }
}
