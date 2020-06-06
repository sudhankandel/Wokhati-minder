import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signup/pages/home/home.dart';
import 'package:signup/pages/pill/ui/homepage/homepage.dart';
import 'package:signup/services/authentication.dart';
import 'package:signup/pages/contact/contact_page.dart';

import 'package:signup/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;


  
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final _buttomNavColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list
     ..add(MyHome())
     ..add(PillHome())
     ..add(Contact())
    ..add(Profilepage(auth: this.widget.auth , logoutCallback: this.widget.logoutCallback,userid: this.widget.userId));
  //  ..add(ProfileDemo());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor:  Color(0XFFe4f0e0),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.th,
                color: _buttomNavColor,
              ),
              title: Text(
                "Overview",
                style: TextStyle(color: _buttomNavColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
               FontAwesomeIcons.pills,
                color: _buttomNavColor,
              ),
              title: Text(
                "Pill",
                style: TextStyle(color: _buttomNavColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.phone,
                color: _buttomNavColor,
              ),
              title: Text(
                "Contact",
                style: TextStyle(color: _buttomNavColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
               FontAwesomeIcons.usersCog,
                color: _buttomNavColor,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: _buttomNavColor),
              )),
            //      BottomNavigationBarItem(
            //  icon: Icon(
            //   FontAwesomeIcons.usersCog,
            //    color: _buttomNavColor,
            //  ),
            //  title: Text(
            //    "Demo",
            //    style: TextStyle(color: _buttomNavColor),
            //  )),

        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}

