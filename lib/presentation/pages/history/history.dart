import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ubermove/presentation/widgets/table_list.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Historial',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 48.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
          decoration: BoxDecoration(
              color: Color(0xffF7F9FC), borderRadius: BorderRadius.circular(4)),
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
        ),
        Expanded(
          child: TableListView(
            margin: EdgeInsetsDirectional.only(top: 21, bottom: 15),
            data: [1, 2, 3, 4],
          ),
        ),
      ],
    );
  }
}
