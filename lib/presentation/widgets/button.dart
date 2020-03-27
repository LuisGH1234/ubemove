import 'package:flutter/material.dart';
import '../../common/constants/colors.dart';

class Button extends StatelessWidget {
  final Color color;
  final void Function() onPressed;
  final String text;
  final double width;
  final bool loading;

  Button(this.text,
      {@required this.onPressed, this.width, this.color, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: this.width ?? MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: this.color ?? $Colors.PRIMARY,
        // colorBrightness: this.color ?? $Colors.PRIMARY,
        onPressed: loading ? null : this.onPressed,
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(
          this.text.toUpperCase(),
          style: TextStyle(
              color: $Colors.SECONDARY_TEXT,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        // borderRadius: BorderRadius.circular(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
