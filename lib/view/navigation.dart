import 'package:flutter/material.dart';

import 'account.dart';
import 'findTrips.dart';
import 'myTrips.dart';
import 'notifications.dart';

/// This is the stateful widget that the main application instantiates.
class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyTrips(),
    FindTrips(),
    Notifications(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map_outlined),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            activeIcon: Icon(Icons.travel_explore),
            label: 'Find Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            activeIcon: Icon(Icons.mail_outline),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            activeIcon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
