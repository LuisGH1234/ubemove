import 'package:flutter/material.dart';
import 'package:ubermove/presentation/pages/auth/login.dart';
import 'package:ubermove/presentation/pages/auth/register.dart';
import 'package:ubermove/presentation/pages/main_page.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Login.PATH: (ctx) => Login(),
    Register.PATH: (ctx) => Register(),
    MainPage.PATH: (ctx) => MainPage(title: 'UberMove'),
  };
}

Route<dynamic> onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
        child: Text("Go back"),
      ),
    ),
  );
}
