import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/pages/auth/login.dart';
import 'package:ubermove/presentation/widgets/widgets.dart';

class Register extends StatefulWidget {
  static const PATH = "/register-form";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _username = "";
  String _password = "";

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(Login.PATH);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: KeyboardSafeArea(
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Logo(
                      width: 200,
                      // height: 100,
                    ),
                  ),
                  Input(
                    onChanged: (value) {
                      _username = value;
                    },
                    hintText: "Nombre",
                    margin: EdgeInsets.only(bottom: 15),
                  ),
                  Input(
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                    hintText: "Celular",
                    margin: EdgeInsets.only(bottom: 15),
                  ),
                  Input(
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                    hintText: "Email",
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
                  Input(
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                    hintText: "Repetir contraseña",
                    margin: EdgeInsets.only(bottom: 15),
                  ),
                  Spacer(),
                  Button(
                    "INICIAR SESIÓN",
                    loading: state.loginEvent.loading,
                    onPressed: () {
                      authBloc.authenticated();
                      // authBloc.login(_username, _password);
                    },
                  ),
                  Center(
                    child: FlatButton(
                        onPressed: () {
                          _navigateToLogin(context);
                        },
                        child: Text(
                          "Iniciar Sesión",
                          style:
                              TextStyle(color: Color(0xffED1C24), fontSize: 12),
                        )),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
