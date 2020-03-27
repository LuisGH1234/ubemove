import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/blocs/auth/auth.bloc.dart';
import 'package:ubermove/presentation/pages/pages.dart' show Login;
import 'package:ubermove/presentation/routes/routes.dart';
import 'package:ubermove/common/assets/images.dart' as images;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    void _navigateTo(BuildContext context) {
      // Funcion de ejemplo para navegar a otra pagina/vista
      const ejemplo = 'ruta que esta definida en presentation/routes/';
      Navigator.of(context).pushNamed(ejemplo);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ValidQuota()));
    }

    return FutureBuilder(
      future: precacheImage(AssetImage(images.LOGO), context),
      builder: (context, snapshot) => MaterialApp(
        title: 'Sodexo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Color(0xffEDF1F7),
          backgroundColor: $Colors.BACKGROUD,
          primaryColor: $Colors.PRIMARY,
          accentColor: $Colors.PRIMARY,
          // splashColor: $Colors.PRIMARY_TEXT,
          // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent)
        ),
        // initialRoute: !state.isAuthenticated ? '/' : HomePage.PATH,
        routes: routes(),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isAuthenticated)
              return Scaffold(
                  body: Center(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Home Page"),
                  RaisedButton(
                    child: Text("Regresar al login"),
                    onPressed: () {
                      authBloc.notAuthenticated();
                    },
                  )
                ],
              )));
            else
              return Login();
          },
        ),
        onUnknownRoute: onUnknownRoute,
      ),
    );
  }
}
