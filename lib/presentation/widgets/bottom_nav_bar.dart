import 'package:flutter/cupertino.dart';
import '../../common/constants/colors.dart';

class BottomNavigationbarStyled extends StatelessWidget {
  final List<Icon> children;
  final int currentIndex;
  final void Function(int) onTap;

  BottomNavigationbarStyled(
      {@required this.children,
      @required this.currentIndex,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(color: $Colors.BOTTOM_NAV_BAR),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: this
            .children
            .asMap()
            .map((i, icon) => MapEntry(
                  i,
                  NavigationbarItem(
                    iconLength: this.children.length,
                    icon: icon,
                    isSelected: i == this.currentIndex,
                    onTap: () {
                      this.onTap(i);
                    },
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}

class NavigationbarItem extends StatelessWidget {
  final Icon icon;
  final bool isSelected;
  final void Function() onTap;
  final int iconLength;

  NavigationbarItem(
      {@required this.icon,
      @required this.isSelected,
      @required this.onTap,
      @required this.iconLength});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Color(0xff2B3797) : Color(0xffFFFFFF);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: this.onTap,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width / this.iconLength,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              // alignment: Alignment.topCenter,
              height: 6,
              child: Container(
                color: color,
              ),
              // decoration: BoxDecoration(color: color),
            ),
            // this.icon
            Padding(
              padding: EdgeInsets.only(bottom: 14.0),
              child: this.icon,
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoBottomNavigationBarItem extends StatelessWidget {
  // final String asset;
  final IconData iconData;
  final bool isSelected;

  CupertinoBottomNavigationBarItem(
      {@required this.iconData, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 4,
          decoration: BoxDecoration(
              color: isSelected ? $Colors.PRIMARY : $Colors.TRANSPARENT),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Icon(
            iconData,
            color: $Colors.PRIMARY_TEXT,
          ),
        ),
      ],
    );
  }
}
