import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/common/constants/api_urls.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/input.dart';

class ProfileUpdate extends StatelessWidget {
  static const PATH = "/profileUpdate";

  String _names = "";
  String _lastnames = "";
  String _phone = "";
  String _address = "";

  Future commitUpdates(String names, lastnames, phone, address) async {
    print(names + lastnames + phone + address);

    //TODO: Usage of preferences for request and changing user on prefs after success
    final path = "$USER_PATH/updateprofile";
    final data = {"id": "1",'firstName': _names, 'lastName': _lastnames, 'phone': _phone};
    return ApiManager.post(path, body: data, tokenRequired: true);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    return Scaffold(
      appBar: AppBar(title: Text('Actualizar datos')),
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35, bottom: 15),
                child: Input(
                  keyboardType: TextInputType.text,
                  hintText: "Nombres",
                  onChanged: (value) {
                    _names = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Input(
                  keyboardType: TextInputType.text,
                  hintText: "Apellidos",
                  onChanged: (value) {
                    _lastnames = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Input(
                  keyboardType: TextInputType.number,
                  hintText: "Celular",
                  onChanged: (value) {
                    _phone = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Input(
                  keyboardType: TextInputType.multiline,
                  hintText: "Direccion",
                  onChanged: (value) {
                    _address = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:35, bottom: 15),
                child: Button(
                  "Actualizar",
                  onPressed: () {commitUpdates(_names, _lastnames, _phone, _address);},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
