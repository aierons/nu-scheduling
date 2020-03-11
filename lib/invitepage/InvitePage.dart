import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './inviteinfo.dart';
import './InvitePageModel.dart';

/// The page where meeting invitations are displayed. Users can accept
/// or delete requests from this page.

// The actual page widget
class InvitePage extends StatefulWidget {
  InvitePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  var _invites;
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
                2, // move 10 down
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

  // Popup confirmation dialog for accepting and rejecting invites
  _createAlertDialog(BuildContext context, bool accepted, InviteInfo invite) {
    String message = "Decline Jeff's meeting?";

    return !accepted
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text(
                    message,
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("Yes"),
                      onPressed: () {
                        Provider.of<InvitePageModel>(context, listen: false)
                            .remove(invite);
                        Navigator.pop(context);
                      },
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ]);
            })
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Meeting Joined!"),
                actions: <Widget>[
                  MaterialButton(
                    elevation: 5.0,
                    child: Text("Ok!"),
                    onPressed: () {
                      Provider.of<InvitePageModel>(context, listen: false)
                          .accept(invite);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
  }

  // Build stack of accept / reject icons
  Widget _buildIconColumn(InviteInfo invite) => Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
//      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.blueAccent,
              size: 50,
            ),
            onPressed: () => _createAlertDialog(context, true, invite),
          ),
          IconButton(
            icon: Icon(
              Icons.not_interested,
              color: Colors.redAccent,
              size: 40,
            ),
            onPressed: () => _createAlertDialog(context, false, invite),
          ),
        ],
      ));

  // Returns a meeting card
  Widget _buildCard(BuildContext context, InviteInfo invite) {
    String title = invite.title;
    String name = invite.name;
    String loc = invite.location;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        // Card info, picture
        children: <Widget>[
          // Card info side
          _buildInfoSection(title, name, loc),
          _buildIconColumn(invite),
        ],
      ),
      decoration: _cardDecoration(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // Invite page
  @override
  Widget build(BuildContext context) {
    final inviteCards = <Widget>[];
    final modelInvites = Provider.of<InvitePageModel>(context).invites;
    modelInvites.forEach((i) {
      var card = _buildCard(context, i);
      inviteCards.add(card);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invitations",
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
      ),
      body: ListView(
        children: inviteCards,
      ),
      backgroundColor: Colors.white70,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
