import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/blocs/user/user.bloc.dart';

class PaymentTMethodList extends StatefulWidget {
  static const PATH = "/paymentTMethodList";

  @override
  State<StatefulWidget> createState() => _PaymentTMethodListState();
}

class _PaymentTMethodListState extends State<PaymentTMethodList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.bloc<UserBloc>().getMyPaymentMethods();
  }

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Metodos de Pago')),
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state.paymentMethodList.loading) return;
            if (state.paymentMethodList.error) {
              showSnackbarError(state.paymentMethodList.message);
            }
          },
          builder: (context, state) {
            if (state.paymentMethodList.loading) {
              return CircularProgressIndicator();
            } else if (state.paymentMethodList.error == true) {
              return Center(
                child: Text(
                    "Lo sentimos ocurrio un problema: ${state.paymentMethodList.message}"),
              );
            }
            return Column(
              children: state.paymentMethodList.data
                  .map((e) => Text(e.description))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
