import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart'
    show showCupertinoModalPopup, CupertinoDatePicker, CupertinoDatePickerMode;
import 'package:flutter/material.dart';
import '../../common/constants/colors.dart';

class RangeDatePicker extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final void Function(DateTime) onSaveDate;
  final void Function(TimeOfDay) onSaveTime;

  RangeDatePicker(
      {@required this.onSaveDate,
      @required this.onSaveTime,
      @required this.date,
      @required this.time});

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

  Future<void> _selectAndroidTime(
      BuildContext context, void Function(TimeOfDay) cb) async {
    final picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      cb(picked);
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
            onTap: () => _select(context, this.onSaveDate),
            child: Text(
              DateFormat('yyyy-MM-dd').format(date) ?? "seleccionar",
              style: TextStyle(color: $Colors.PLACEHOLDER),
            ),
          ),
          Text(
            "   -   ",
            style: TextStyle(color: $Colors.PLACEHOLDER),
          ),
          GestureDetector(
            // onTap: () {},
            onTap: () => _selectAndroidTime(context, this.onSaveTime),
            child: Text(
              "${time.hour}:${time.minute}" ?? "seleccionar",
              style: TextStyle(color: $Colors.PLACEHOLDER),
            ),
          ),
          // GestureDetector(
          //   // onTap: () {},
          //   onTap: () => _select(context, this.onSaveEndDate),
          //   child: Text(
          //     DateFormat('yyyy-MM-dd').format(endDate) ?? "seleccionar",
          //     style: TextStyle(color: $Colors.PLACEHOLDER),
          //   ),
          // ),
          Spacer(),
          Icon(
            Icons.calendar_today,
            color: $Colors.PRIMARY,
          ),
        ],
      ),
    );
  }
}
