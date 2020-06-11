import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/pages/auth/register.dart';
import 'package:ubermove/presentation/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';

class Login extends StatefulWidget {
  static const PATH = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _username = "";
  String _password = "";

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(Register.PATH);
  }

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void getPermission() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator.checkGeolocationPermissionStatus()
        .then((status) => {
      print(status.toString())
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state.loginEvent.loading) return;
          if (state.loginEvent.error) {
            showSnackbarError(state.loginEvent.message);
          }
        }, builder: (context, state) {
          return Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Logo(width: 250),
                ),
                Spacer(),
                Input(
                  onChanged: (value) {
                    _username = value;
                  },
                  hintText: "Usuario",
                  margin: EdgeInsets.only(bottom: 15),
                ),
                Input(
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
                  hintText: "Contraseña",
                  margin: EdgeInsets.only(bottom: 15),
                ),
                Button(
                  "INICIAR SESIÓN",
                  loading: state.loginEvent.loading,
                  onPressed: () {
                    // authBloc.authenticated();
                    authBloc.login(_username, _password);
                  },
                ),
                Center(
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                        style:
                            TextStyle(color: Color(0xffED1C24), fontSize: 12),
                      )),
                ),
                Spacer(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "¿Deseas afiliarte como comercio?",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14,
                            fontStyle: FontStyle.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FlatButton(
                          onPressed: () {
                            _navigateToRegister(context);
                          },
                          child: Text(
                            "Registrate aqui",
                            style: TextStyle(
                                color: Color(0xffED1C24), fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
