import 'package:flutter/material.dart';
import '../../common/constants/colors.dart';

class Input extends Container {
  final TextInputType keyboardType;
  final double height;
  final String hintText;
  final TextEditingController controller;
  // final String Function(String) validator;
  // final void Function(String) onSaved;
  final void Function(String) onChanged;
  final bool obscureText;

  Input(
      {this.hintText,
      this.controller,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      // this.onSaved,
      // this.validator,
      AlignmentGeometry alignment,
      EdgeInsetsGeometry padding,
      Color color,
      Decoration decoration,
      Decoration foregroundDecoration,
      double width,
      this.height,
      BoxConstraints constraints,
      EdgeInsetsGeometry margin,
      Matrix4 transform})
      : super(
            alignment: alignment,
            padding: padding,
            color: color,
            decoration: decoration,
            foregroundDecoration: foregroundDecoration,
            width: width,
            height: height,
            constraints: constraints,
            margin: margin,
            transform: transform);

  @override
  Widget get child => TextField(
        keyboardType: keyboardType,
        obscureText: this.obscureText,
        // validator: this.validator,
        // onSaved: this.onSaved,
        onChanged: this.onChanged,
        // autofocus: false,
        controller: this.controller,
        decoration: InputDecoration(
          // suffixText: 'bpm',
          // prefix: Container(
          //   child: FlatButton(
          //     padding: EdgeInsets.all(0),
          //     onPressed: () {},
          //     child: Text('A'),
          //     color: Colors.amberAccent,
          //   ),
          //   height: 24,
          //   width: 24,
          // ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              width: 2,
              color: $Colors.PRIMARY,
              style: BorderStyle.solid,
            ),
          ),
          filled: true,
          fillColor: $Colors.LIGHT_PRIMARY,
          hintStyle: TextStyle(color: $Colors.PLACEHOLDER),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          isDense: true,
        ),
        // placeholder: hintText,
        // placeholderStyle: TextStyle(color: $Colors.PLACEHOLDER, fontSize: 15),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(4),
        //   color: $Colors.LIGHT_PRIMARY,
        // ),
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        style: TextStyle(fontSize: 15),
      );
}
