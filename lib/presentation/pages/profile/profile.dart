import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/pages/profile/profileUpdate.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/layout.dart';

class Profile extends StatelessWidget {
  // void _navigateToFaq(BuildContext context) {
  //   Navigator.of(context).pushNamed(FaqViewer.PATH);
  //   // Navigator.push(
  //   //     context, MaterialPageRoute(builder: (context) => ValidQuota()));
  // }
  Future<String> encodeUser =
      SharedPreferences.getInstance().then((value) => value.getString('user'));

  Future navigateToProfileUpdate(context) async {
    //Navigator.pushNamed(context, ProfileUpdate.PATH);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileUpdate()));
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (constext, state) {
          final userData = state.user.value;
          return Layout(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  "Mi Perfil",
                  style: TextStyle(
                    fontSize: 20, /* color: $Colors.PRIMARY_TEXT*/
                  ),
                ),
              ),
              Text(
                "Nombre",
                style: TextStyle(
                  fontSize: 14, /* color: $Colors.PRIMARY_TEXT*/
                ),
              ),
              Text(
                "${userData.firstName} ${userData.lastName}",
                style: TextStyle(
                    fontSize: 20,
                    // color: $Colors.PRIMARY_TEXT,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                "Email ",
                style: TextStyle(
                  fontSize: 14, /*color: $Colors.PRIMARY_TEXT*/
                ),
              ),
              Text(
                "${userData.email}",
                style: TextStyle(
                    fontSize: 20,
                    // color: $Colors.PRIMARY_TEXT,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                "Dirección",
                style: TextStyle(
                  fontSize: 14, /*color: $Colors.PRIMARY_TEXT*/
                ),
              ),
              Text(
                "Lince",
                style: TextStyle(
                    fontSize: 20,
                    // color: $Colors.PRIMARY_TEXT,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Button("ACTUALIZAR DATOS", onPressed: () {
                navigateToProfileUpdate(context);
              }),
              Spacer(),
              Button("CERRAR SESIÓN", onPressed: () {
                authBloc.notAuthenticated();
              }),
              Spacer(),
            ],
          );
        });

    // return FutureBuilder(
    //     future: encodeUser,
    //     builder: (context, snaphot){
    //       if(snaphot.hasData)
    //       {
    //         User userData = User.fromJson(json.decode(snaphot.data));
    //         return Layout(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(bottom: 40),
    //         child: Text(
    //           "Mi Perfil",
    //           style: TextStyle(
    //             fontSize: 20, /* color: $Colors.PRIMARY_TEXT*/
    //           ),
    //         ),
    //       ),
    //       Text(
    //         "Nombre",
    //         style: TextStyle(
    //           fontSize: 14, /* color: $Colors.PRIMARY_TEXT*/
    //         ),
    //       ),
    //       Text(
    //         "${userData.firstName}",
    //         style: TextStyle(
    //             fontSize: 20,
    //             // color: $Colors.PRIMARY_TEXT,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(height: 30),
    //       Text(
    //         "Email ",
    //         style: TextStyle(
    //           fontSize: 14, /*color: $Colors.PRIMARY_TEXT*/
    //         ),
    //       ),
    //       Text(
    //         "${userData.email}",
    //         style: TextStyle(
    //             fontSize: 20,
    //             // color: $Colors.PRIMARY_TEXT,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(height: 30),
    //       Text(
    //         "Dirección",
    //         style: TextStyle(
    //           fontSize: 14, /*color: $Colors.PRIMARY_TEXT*/
    //         ),
    //       ),
    //       Text(
    //         "Lince",
    //         style: TextStyle(
    //             fontSize: 20,
    //             // color: $Colors.PRIMARY_TEXT,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       Spacer(),
    //       Button("ACTUALIZAR DATOS", onPressed: () {
    //         navigateToProfileUpdate(context);
    //       }),
    //       Spacer(),
    //       Button("CERRAR SESIÓN", onPressed: () {
    //         authBloc.notAuthenticated();
    //       }),
    //       Spacer(),
    //     ],
    //   );
    //       }
    //   else
    //     if(snaphot.hasError)
    //       return Text("Error");
    //     else
    //       return Center(child: CircularProgressIndicator(),);
    //     }
    // );
  }
}
