import 'package:flutter/material.dart';
import 'package:layout/home_page.dart';
import 'package:layout/login/authenticate.dart';
import 'package:layout/login_page.dart';
import 'package:layout/user_model.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
