import 'package:flutter/material.dart';

class FindTrips extends StatefulWidget {
  const FindTrips({Key? key}) : super(key: key);
  @override
  _FindTripsState createState() => _FindTripsState();
}

class _FindTripsState extends State<FindTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Trips"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Find Trips',
            ),
          ],
        ),
      ),
    );
  }
}
