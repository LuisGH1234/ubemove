import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoTabBar;
import 'package:ubermove/presentation/pages/history/history.dart';
import 'package:ubermove/presentation/pages/profile/profile.dart';
import 'package:ubermove/presentation/widgets/widgets.dart';

import 'home/home.dart';

class MainPage extends StatefulWidget {
  final String title;
  static const PATH = "/home_page";

  MainPage({@required this.title});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndexBar = Bar.Home;

// PageStorage
// https://www.youtube.com/watch?v=EyLqj9L_Tck
  Widget _setBody(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    switch (_selectedIndexBar) {
      case Bar.Home:
        return Home();
      case Bar.History:
        return History();
      case Bar.Profile:
        return Profile();
      default:
        return Text("Error Page");
    }
  }

  CupertinoTabBar _bottomNavBar() {
    // BottomAppBar(
    //     shape: CircularNotchedRectangle(),
    //     color: Colors.blueGrey,
    //     notchMargin: 2.0,
    //     clipBehavior: Clip.antiAlias,
    //     child: BottomNavigationBar(items: [
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.cancel), title: Text("Title")),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.cancel), title: Text("Title")),
    //     ]),
    //   )
    return CupertinoTabBar(
      iconSize: 20.0,
      items: [
        BottomNavigationBarItem(
          icon: CupertinoBottomNavigationBarItem(
            // asset: 'assets/svg/home.svg',
            iconData: Icons.home,
            isSelected: _selectedIndexBar == Bar.Home,
          ),
        ),
        BottomNavigationBarItem(
          icon: CupertinoBottomNavigationBarItem(
            // asset: 'assets/svg/history.svg',
            iconData: Icons.history,
            isSelected: _selectedIndexBar == Bar.History,
          ),
        ),
        BottomNavigationBarItem(
          icon: CupertinoBottomNavigationBarItem(
            // asset: 'assets/svg/user.svg',
            iconData: Icons.person,
            isSelected: _selectedIndexBar == Bar.Profile,
          ),
        ),
      ],
      currentIndex: _selectedIndexBar,
      onTap: (index) {
        setState(() {
          _selectedIndexBar = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      // backgroundColor: $Colors.BACKGROUD,
      backgroundColor: Color(0xffFFFFFF),
      // tabBar: tabBar,
      // tabBuilder: (context, index) => _setBody(tabBar.preferredSize.height),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _bottomNavBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: _setBody(context, _scaffoldKey),
      )),
    );
  }
}

class Bar {
  static const int Home = 0;
  static const int History = 1;
  static const int Profile = 2;
}
