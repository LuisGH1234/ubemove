import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/common/constants/api_urls.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/presentation/blocs/user/bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/table_list.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final _flexKey = GlobalKey<ScaffoldState>();
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
    context.bloc<UserBloc>().getMyJobRecord();
  }

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _flexKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      key: _flexKey,
      listener: (context, state) {
        if (state.jobListEvent.loading) return;
        if (state.jobListEvent.error) {
          showSnackbarError(state.jobListEvent.message);
        }
      },
      builder: (context, state) {
        // if (state.jobListEvent.loading) {
        //   return Center(child: CircularProgressIndicator());
        // } else
        if (state.jobListEvent.error == true) {
          return Center(
            child: Text(
                "Lo sentimos ocurrio un problema: ${state.jobListEvent.message}"),
          );
        }
        return Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Text(
                'Historial',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
                visible: false,
                child: Container(
                  height: 48.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
                  decoration: BoxDecoration(
                      color: Color(0xffF7F9FC),
                      borderRadius: BorderRadius.circular(4)),
                  width: MediaQuery.of(context).size.width - 20,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Transform.rotate(
                      angle: -50 * pi / 100,
                      child: Icon(Icons.chevron_left),
                    ),
                    // iconEnabledColor: $Colors.PRIMARY,
                    isExpanded: true,
                    iconSize: 28,
                    elevation: 0,
                    style: TextStyle(color: Color(0xff8F9BB3)),
                    underline: Container(height: 0),
                    iconDisabledColor: Colors.grey,
                    disabledHint: Text(
                      "últimos 30 días",
                      style: TextStyle(color: Colors.grey),
                    ),
                    // onChanged: null,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )),
            Expanded(
              child: TableListView(
                  loading: state.jobListEvent.loading,
                  onRefresh: () async {
                    context.bloc<UserBloc>().getMyJobRecord();
                  },
                  margin: EdgeInsetsDirectional.only(top: 21, bottom: 15),
                  data: state.jobListEvent.data),
            )
          ],
        );
      },
    );
  }
}
