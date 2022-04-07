import 'package:flutter/material.dart';

import 'account.dart';
import 'findTrips.dart';
import 'myTrips.dart';
import 'notifications.dart';
import 'package:passenger/globals.dart' as globals;

/// This is the stateful widget that the main application instantiates.
class Navigation extends StatefulWidget {
  const Navigation({Key? key, this.initialSelectedIndex = 0}) : super(key: key);
  final int initialSelectedIndex;

  @override
  State<Navigation> createState() =>
      _NavigationState(this.initialSelectedIndex);
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationState extends State<Navigation> {
  int _selectedIndex;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyTrips(),
    FindTrips(),
    Notifications(),
    Account(),
  ];

  _NavigationState(this._selectedIndex);

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
        iconSize: 32,
        items: <BottomNavigationBarItem>[
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
            icon: notificationCount() > 0
                ? Stack(
                    children: <Widget>[
                      Icon(Icons.mail_outline),
                      Positioned(
                        left: 16,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            notificationCount().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                : Icon(Icons.mail_outline),
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }

  notificationCount() {
    int count = 0;
    for (dynamic request in globals.requests.values) {
      if (globals.trips[request["tripId"]]["driverUserId"] ==
              globals.currentUserId &&
          !request["read"]) {
        count++;
      }
    }
    return count;
  }
}
