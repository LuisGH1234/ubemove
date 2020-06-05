import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/services/user.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/pages/auth/login.dart';
import 'package:ubermove/presentation/widgets/widgets.dart';

import '../home/home.dart';

class Register extends StatefulWidget {
  static const PATH = "/register-form";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  String _firstname = "";
  String _lasttname = "";
  String _phone = "";
  String _username = "";
  String _password = "";
  String _repeatpassword = "";

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message ?? 'Error'),
      backgroundColor: $Colors.ACCENT_RED,
    );
    print('Holi');
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
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          print(state.registroEvent);
          print(state.registroEvent.loading);
          if (state.registroEvent.loading) return;
          if (state.registroEvent.error)
            showSnackbarError(state.registroEvent.message);
          else
            Navigator.of(context).pushNamed("/");
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkey,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              //padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  // direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 50),
                      child: Logo(
                        width: 200,
                        // height: 100,
                      ),
                    ),
                    // Spacer(),
                    _setfirstName(),
                    Divider(),
                    _setlastName(),
                    Divider(),
                    _setPhone(),
                    Divider(),
                    _setUserName(),
                    Divider(),
                    _setPassword(),
                    Divider(),
                    _setRepeatPassword(),
                    // Spacer(),
                    SizedBox(height: 40),
                    Button(
                      "Registrarse",
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          print("Hola_Registro");
                          User data = new User(
                              email: _username,
                              firstName: _firstname,
                              lastName: _lasttname,
                              active: true,
                              password: _password);
                          authBloc.registro(data);
                        }
                      },
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/");
                        },
                        child: Text(
                          "Iniciar Sesión",
                          style:
                              TextStyle(color: Color(0xffED1C24), fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _setfirstName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Ingrese su primer nombre',
        labelText: 'Nombre',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.account_box),
      ),
      onChanged: (valor) {
        setState(() {
          _firstname = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese su nombre por favor';
        if (valor.length > 50)
          return 'Su nombre tiene que tener menos de 50 caracteres';
        return null;
      },
    );
  }

  Widget _setlastName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Ingrese su primer apellido',
        labelText: 'Apellido',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.account_box),
      ),
      onChanged: (valor) {
        setState(() {
          _lasttname = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese su Apellido por favor';
        if (valor.length > 50)
          return 'Su apellido tiene que tener menos de 50 caracteres';
        return null;
      },
    );
  }

  Widget _setPhone() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Ingrese su número de celular',
        labelText: 'Celular',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.phone),
      ),
      onChanged: (valor) {
        setState(() {
          _phone = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese su celular por favor';
        if (valor.length < 9)
          return 'Su celular tiene que tener como mínmo 9 cifras';
        return null;
      },
    );
  }

  Widget _setUserName() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Ingrese su correo electrónico',
        labelText: 'Correo',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.email),
      ),
      onChanged: (valor) {
        setState(() {
          _username = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese su correo por favor';
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(valor);
        if (emailValid != true) return 'Su correo no es valido';
        return null;
      },
    );
  }

  Widget _setPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //     counter: Text('Letras ${_nombre.length}'),
        hintText: 'Ingrese su contraseña',
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese una constraseña por favor';
        if (valor.length < 6)
          return 'Su contraseña tiene que tener como mínmo 6 cifras';
        return null;
      },
    );
  }

  Widget _setRepeatPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //     counter: Text('Letras ${_nombre.length}'),
        hintText: 'Ingrese nuevamente su contraseña',
        labelText: 'Repita su contraseña',
        labelStyle: TextStyle(color: $Colors.PLACEHOLDER),
        hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) {
        setState(() {
          _repeatpassword = valor;
        });
      },
      validator: (valor) {
        if (valor.isEmpty)
          return 'Ha dejado vacio este campo, ingrese nuevamente la contraseña por favor';
        if (valor != _password) return 'Su contraseña no coincide';
        return null;
      },
    );
  }
}
