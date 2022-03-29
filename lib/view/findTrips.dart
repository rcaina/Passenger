import 'package:flutter/material.dart';
import 'package:passenger/view/tripDetails.dart';
import 'package:passenger/globals.dart' as globals;
// import 'package:passenger/view/findTripFilter.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TripDetails()),
              );
            },
          ),
        ],
      ),
      body: Center(
          // child: ListView.builder(
          //     itemCount: globals.accountData.length,
          //     itemBuilder: (context, index) {
          //       return institutionCard(globals.accountData[index]);
          //     },
          //   ),,
          ),
    );
  }
}
