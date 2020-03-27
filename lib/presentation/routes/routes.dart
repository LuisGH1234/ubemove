import 'package:flutter/material.dart';
import 'package:ubermove/presentation/pages/pages.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Login.PATH: (ctx) => Login(),
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
