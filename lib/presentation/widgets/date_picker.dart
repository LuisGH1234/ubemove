import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart'
    show showCupertinoModalPopup, CupertinoDatePicker, CupertinoDatePickerMode;
import 'package:flutter/material.dart';
import '../../common/constants/colors.dart';

class RangeDatePicker extends StatelessWidget {
  final void Function(DateTime) onSaveSartDate;
  final void Function(DateTime) onSaveEndDate;

  RangeDatePicker(
      {@required this.onSaveSartDate, @required this.onSaveEndDate});

  Future<void> _selectAndroidDate(
      BuildContext context, void Function(DateTime) cb) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      cb(DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _selectiOSDate(
      BuildContext context, void Function(DateTime) cb) async {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime(2015, 8),
                maximumDate: DateTime(2100),
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (dateTime) {
                  cb(dateTime);
                }),
          );
        });
  }

  void _select(BuildContext context, void Function(DateTime) cb) {
    // _selectiOSDate(context, cb);
    if (Platform.isAndroid) {
      _selectAndroidDate(context, cb);
    } else {
      _selectiOSDate(context, cb);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      decoration: BoxDecoration(
        color: $Colors.DATEPICKER,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            // onTap: () {},
            onTap: () => _select(context, this.onSaveSartDate),
            child: Text(
              "01/02/2020",
              style: TextStyle(color: $Colors.PLACEHOLDER),
            ),
          ),
          Text(
            "   -   ",
            style: TextStyle(color: $Colors.PLACEHOLDER),
          ),
          GestureDetector(
            // onTap: () {},
            onTap: () => _select(context, this.onSaveEndDate),
            child: Text(
              "10/02/2020",
              style: TextStyle(color: $Colors.PLACEHOLDER),
            ),
          ),
          Spacer(),
          Icon(
            Icons.person,
            color: $Colors.PRIMARY,
          ),
        ],
      ),
    );
  }
}
