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
// ignore: must_be_immutable
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
    // Left navigation arrow
    Widget leftArrow = Container(
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: Icon(Icons.arrow_back, size: 50, color: Colors.black)),
      ),
    );

    // Left/right arrows to move between pages
    Widget navArrows = Row(
      children: <Widget>[
        Expanded(child: Align(alignment: Alignment.topLeft, child: leftArrow)),
      ],
    );

    Widget locationSetup = Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Stack(
        children: <Widget>[
          navArrows,
          Positioned(
            top: 110,
            left: 20,
            child: Container(
                child: Text(
                  "Location",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 60),
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 180, 10, 10),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: _getListItemTile,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            locationSetup
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
            InviteInfo newInvite = new InviteInfo(
                _invite.title,
                _invite.getName,
                newLoc,
                _invite.getDate,
                _invite.getStart,
                _invite.getEnd,
                _invite.getInvitees);
            _model.replaceAccepted(_invite, newInvite);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        ),
      ),
    );
  }
}
