import 'package:flutter/material.dart';
import '../../common/constants/colors.dart';

class HomeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final double height;

  HomeCard({@required this.child, this.margin, this.height = 113});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: $Colors.LIGHT_PRIMARY,
        elevation: 5.0,
        margin: this.margin,
        child: Container(
          child: this.child,
          height: this.height,
        ),
      ),
    );
    // return Expanded(
    //   child: Container(
    //     padding: EdgeInsets.all(15),
    //     margin: this.margin,
    //     // width: 149.0 - this.margin.horizontal,
    //     height: this.height,
    //     child: this.child,
    //     decoration: BoxDecoration(
    //       boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1.0)],
    //       borderRadius: BorderRadius.circular(10),
    //       color: $Colors.LIGHT_PRIMARY,
    //     ),
    //   ),
    // );
  }
}

class HomeTextCard extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight fontWeight;

  HomeTextCard(this.data,
      {@required this.fontSize, this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.data.toUpperCase(),
      style: TextStyle(
        color: $Colors.PRIMARY_TEXT,
        fontWeight: this.fontWeight,
        fontSize: this.fontSize,
      ),
    );
  }
}
