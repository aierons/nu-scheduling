import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePage.dart';
import './invitepage/InvitePageModel.dart';
import 'invitepage/inviteinfo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    InvitePageModel invModel = Provider.of<InvitePageModel>(context);
    int invCt = invModel.numInv;
    // Border for cards
    BoxDecoration _cardDecoration() {
      return BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.6,
                blurRadius: 5,
                // LTRB
                offset: Offset(
                  0, // move 10 right
                  3, // move 10 down
                ))
          ]);
    }

    // Return text section with title, name, date info
    Widget _buildInfoSection(String title, String name, String loc) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Title+name, location, time+day
          children: <Widget>[
            // Title+name
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                child: Row(children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  SizedBox(width: 8),
                  Text(name,
                      style: TextStyle(color: Colors.grey[500], fontSize: 18))
                ])),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Row(children: <Widget>[
                  Icon(Icons.location_on, color: Theme.of(context).accentColor),
                  Text(
                    loc,
                  )
                ])),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Row(children: <Widget>[
                  Icon(Icons.access_time, color: Theme.of(context).accentColor),
                  Text(
                    "2pm - 3pm",
                  ),
                  SizedBox(width: 8),
                  Text(
                    "M",
                  )
                ]))
          ],
        ));

    // Returns a meeting card
    Widget _buildCard(BuildContext context, InviteInfo invite) {
      String title = invite.title;
      String name = invite.name;
      String loc = invite.location;
      String img = loc == "Snell Library" ? "snell" : "curry";
      return Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          // Card info, picture
          children: <Widget>[
            // Card info side
            _buildInfoSection(title, name, loc),
            ClipRRect(
                child: Image.asset('images/$img.jpg',
                    width: 125, height: 150, fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)))
          ],
        ),
        decoration: _cardDecoration(),
      );
    }

    final acceptedMeetings = <Widget>[];
    invModel.accepted.forEach((i) {
      var card = _buildCard(context, i);
      acceptedMeetings.add(card);
    });

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'random text label here to display stuff',
        softWrap: true,
      ),
    );

    Widget mailButton = new Stack(children: <Widget>[
      IconButton(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
          icon: Icon(Icons.mail, size: 30),
          onPressed: () => Navigator.of(context).pushNamed("/invitepage")),
      invCt > 0
          ? new Positioned(
        right: 11,
        top: 11,
        child: new Container(
          padding: EdgeInsets.all(2),
          decoration: new BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          child: Text(
            '$invCt',
            style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : new Container()
    ]);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[mailButton],
        centerTitle: true,
        title: Text(
          "meetNEU",
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
      ),
      body: ListView(children: acceptedMeetings),
      backgroundColor: Colors.white70,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
