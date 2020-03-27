import 'package:flutter/material.dart';

class KeyboardSafeArea extends StatelessWidget {
  final Widget child;

  KeyboardSafeArea({@required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: this.child,
        ),
      ),
    );
  }
}
