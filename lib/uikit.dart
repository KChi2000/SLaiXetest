import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/ringing/bell.dart';
import 'package:flutter_ui_kit/todaystory/todaystory.dart';

import 'browsing/browsing.dart';
import 'filters/filters.dart';
import 'howtomake/howtomake.dart';
import 'me/me.dart';

class UIKitPage extends StatefulWidget {
  @override
  _UIKitPageState createState() {
    return _UIKitPageState();
  }
}

class _UIKitPageState extends State<UIKitPage> {
  var _selectedIndex = 0;
  final _tabPages = [
    TodayStoryTabPage(),
    HowToMakeTabPage(),
    FiltersTabPage(),
    BrowsingTabPage(),
    Bell(),
    MeTabPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('AAAA'),
//        centerTitle: true,
//      ),
      body: _tabPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset("asset/icons/homereal.svg",color: _selectedIndex == 0? Colors.black: Color.fromARGB(255, 83, 82, 82),), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/ticket.svg",color:  _selectedIndex == 1? Colors.black:Color.fromARGB(255, 83, 82, 82)), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset("asset/icons/home.svg",color: _selectedIndex == 2? Colors.black:Color.fromARGB(255, 83, 82, 82)), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset("asset/icons/h.svg",color: _selectedIndex == 3? Colors.black:Color.fromARGB(255, 83, 82, 82)), label: ''),
           BottomNavigationBarItem(icon: SvgPicture.asset("asset/icons/bell.svg",color: _selectedIndex == 4? Colors.black:Color.fromARGB(255, 83, 82, 82)), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/account.svg",color: _selectedIndex == 5? Colors.black:Color.fromARGB(255, 83, 82, 82)), label: ''),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.brown,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
