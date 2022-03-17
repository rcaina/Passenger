import 'package:flutter/material.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({Key? key}) : super(key: key);
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'My Trips',
            ),
          ],
        ),
      ),
    );
  }
}
