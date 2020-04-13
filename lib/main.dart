import 'package:flutter/material.dart';
import 'package:layout/login/wrapper.dart';
import 'package:layout/services/auth.dart';
import 'package:layout/user_model.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePage.dart';
import './invitepage/InvitePageModel.dart';
import 'home_page.dart';
import 'meet_creation_page.dart';
import 'login_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => InvitePageModel(),
      child: Consumer<InvitePageModel>(builder: (context, model, child) {
        return StreamProvider<User>.value(
          value: AuthService().user,
          child:
              MaterialApp(title: 'NU Scheduling', initialRoute: "/", routes: {
            "/": (BuildContext context) => Wrapper(),
            "/invitepage": (BuildContext context) => InvitePage(),
            "/createmeeting": (BuildContext context) => MeetCreationPage(),
          },)
        );
      })));
}
