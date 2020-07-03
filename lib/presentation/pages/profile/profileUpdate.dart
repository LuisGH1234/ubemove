import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/common/constants/api_urls.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/blocs/user/bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/input.dart';

class ProfileUpdate extends StatefulWidget {
  static const PATH = "/profileUpdate";

  @override
  State<StatefulWidget> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _user;
  String _names = "";
  String _lastnames = "";
  String _phone = "";
  // String _address = "";

  @override
  void initState() {
    super.initState();
    final user = context.bloc<AuthBloc>().state.user.value;
    setState(() {
      _user = user;
      _names = user.firstName;
      _lastnames = user.lastName;
      _phone = user.phone;
    });
  }

  Future commitUpdates(
      BuildContext context, String names, lastnames, phone) async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt('userID');

    final path = "$USER_PATH/updateprofile";
    final data = {
      "id": userID,
      'firstName': _names,
      'lastName': _lastnames,
      'phone': _phone
    };
    Navigator.pop(context);
    return ApiManager.post(path, body: data, tokenRequired: true);
  }

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message ?? 'Error'),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<UserBloc>();

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Actualizar datos')),
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                print(state.updateProfileEvent);
                if (state.updateProfileEvent.loading == true) return;
                if (state.updateProfileEvent.error == true)
                  showSnackbarError(state.updateProfileEvent.message);
                else {
                  context.bloc<AuthBloc>().setUser(User(
                      active: true,
                      email: _user.email,
                      firstName: _names,
                      lastName: _lastnames,
                      id: _user.id,
                      phone: _phone));
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 15),
                      child: Input(
                        initialValue: _names,
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
                        initialValue: _lastnames,
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
                        initialValue: _phone,
                        keyboardType: TextInputType.number,
                        hintText: "Celular",
                        onChanged: (value) {
                          _phone = value;
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 15),
                    //   child: Input(
                    //     keyboardType: TextInputType.multiline,
                    //     hintText: "Direccion",
                    //     onChanged: (value) {
                    //       _address = value;
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 15),
                      child: Button(
                        "Actualizar",
                        onPressed: () {
                          bloc.udpdateProfile(User(
                              id: _user.id,
                              firstName: _names,
                              lastName: _lastnames,
                              phone: _phone));
                          // commitUpdates(context, _names, _lastnames, _phone);
                        },
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
