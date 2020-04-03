import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePage.dart';
import './invitepage/InvitePageModel.dart';
import 'home_page.dart';
import 'meet_creation_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => InvitePageModel(),
      child: Consumer<InvitePageModel>(builder: (context, model, child) {
        return MaterialApp(title: 'NU Scheduling', initialRoute: "/", routes: {
          "/": (BuildContext context) => HomePage(),
          "/invitepage": (BuildContext context) => InvitePage(),
          "/createmeeting": (BuildContext context) => MeetCreationPage(),
        });
      })));
}
