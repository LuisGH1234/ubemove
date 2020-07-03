import 'package:flutter/material.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/widgets/logo.dart';

class Layout extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;
  final bool isKeyboardSafeArea;

  Layout({
    @required this.children,
    this.horizontalPadding = 0.0,
    this.isKeyboardSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      // color: $Colors.BACKGROUD,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // SvgPicture.asset('assets/svg/Sodexo_logo 1.svg', width: 150),
          Logo(
            width: 150,
            margin: EdgeInsets.symmetric(vertical: 40),
          ),
          ...this.children,
        ],
      ),
    );
    if (!isKeyboardSafeArea)
      return container;
    else
      // return KeyboardSafeArea(child: container);
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: container,
      );
  }
}
