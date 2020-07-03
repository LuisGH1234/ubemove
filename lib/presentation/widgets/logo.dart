import 'package:flutter/material.dart';
import 'package:ubermove/common/assets/images.dart' as images;

class Logo extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  Logo({this.width, this.margin, this.padding, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      child: Center(
        // child: Icon(
        //   SodexoLogo.sodexo_logo_1,
        //   size: 40,
        //   color: Color(0xff2B3797),
        // ),
        child: Image.asset(
          images.LOGO,
          width: this.width,
          height: height,
        ),
      ),
    );
  }
}
