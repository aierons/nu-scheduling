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
  }
}
