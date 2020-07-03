import 'package:flutter/material.dart';
import 'package:ubermove/presentation/pages/auth/register.dart';
import 'package:ubermove/presentation/pages/home/paymentMethod.dart';
import 'package:ubermove/presentation/pages/home/specifyDestination.dart';
import 'package:ubermove/presentation/pages/home/transportDetail.dart';
import 'package:ubermove/presentation/pages/profile/profileUpdate.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    // Login.PATH: (ctx) => Login(),
    Register.PATH: (ctx) => Register(),
    PaymentTMethodList.PATH: (ctx) => PaymentTMethodList(),
    // MainPage.PATH: (ctx) => MainPage(title: 'UberMove'),
    TransportDetail.PATH: (ctx) => TransportDetail(),
    SpecifyDestination.PATH: (ctx) => SpecifyDestination(),
    ProfileUpdate.PATH: (ctx) => ProfileUpdate(),
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
