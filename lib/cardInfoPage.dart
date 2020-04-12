import 'package:flutter/material.dart';
import './invitepage/inviteinfo.dart';
import 'invitepage/InvitePageModel.dart';
import 'package:intl/intl.dart';

// Page that displays a card's information in verbose format.
// Displayed when user's tap on a card
// ignore: must_be_immutable
class CardInfoPage extends StatefulWidget {
  InviteInfo _invite;
  InvitePageModel _model;

  CardInfoPage(InviteInfo invite, InvitePageModel model) {
    this._invite = invite;
    this._model = model;
  }

  @override
  _CardInfoPage createState() => _CardInfoPage(_invite, _model);
}

class _CardInfoPage extends State<CardInfoPage> {
  InviteInfo _invite;
  InvitePageModel _model;

  _CardInfoPage(InviteInfo invite, InvitePageModel model) {
    this._invite = invite;
    this._model = model;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = _invite.getTitle;
    var name = _invite.getName;
    var loc = _invite.getLoc;
    var locString;
    switch (loc) {
      case "Curry Student Center":
        locString = "curry";
        break;
      case "Snell Library":
        locString = "snell";
        break;
      case "Richards Hall":
        locString = "richards";
        break;
      case "Ryder Hall":
        locString = "ryder";
        break;
    }

    Widget locImage = new Image.asset('images/$locString.jpg',
        width: 125, height: 150, fit: BoxFit.cover);

    // Meeting title and exit button
    Widget titleBar = Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
        decoration: new BoxDecoration(
//          color: Colors.amber[600],
            color: Color.fromRGBO(175, 209, 237, 1.0)
//          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Text(title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400)),
            )),
            IconButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                )),
          ],
        ));

    String date = new DateFormat.yMMMd().format(_invite.getDate);
    String startTime = _invite.getStart.format(context).toString();
    String endTime = _invite.getEnd.format(context).toString();

    Widget timeInfo = Container(
      padding: const EdgeInsets.fromLTRB(20,15,0,0),
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("WHEN",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,0,0),
              child:
              Text("$startTime - $endTime",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: Color.fromRGBO(102, 102, 102,1))),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,0,0),
              child:
              Text("$date",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: Color.fromRGBO(102, 102, 102,1))),
            )
          ]
        )
      ],
    ));

    Widget locInfo = Container(
        padding: const EdgeInsets.fromLTRB(20,30,0,0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("WHERE",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,0,0),
                  child:
                  Text(_invite.getLoc,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                          color: Color.fromRGBO(102, 102, 102,1))),
                )
              ],
            ),
          ],
        ));

    // Build contact info
    Widget _buildContact(context, i) {
      return Container(
          padding: const EdgeInsets.fromLTRB(15,5,0,5),
          child: Row(
            children: <Widget>[
              Icon(Icons.person_outline,
              size: 25),
              Text("  " + i,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(102, 102, 102,1)
              ),)
            ],
      ));
    }

    final inviteeWidgets = <Widget>[];
    _invite.getInvitees.forEach((i) {
      var contact = _buildContact(context, i);
      inviteeWidgets.add(contact);
    });

    Widget pplInfo = Container(
        padding: const EdgeInsets.fromLTRB(20,30,0,0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("WHO",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
            Column(
              children: inviteeWidgets,
            )
          ],
        ));

    // Entire page
    Widget cardInfo = Container(
        child: Column(
      children: <Widget>[titleBar, timeInfo, locInfo, pplInfo],
    ));

    return Scaffold(body: cardInfo);
  }
}
