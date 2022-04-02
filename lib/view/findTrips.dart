import 'package:flutter/material.dart';
import 'package:passenger/view/findTripFilter.dart';
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
                MaterialPageRoute(builder: (context) => const FindTripFilter()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: globals.trips.length,
          itemBuilder: (context, index) {
            String key = globals.trips.keys.elementAt(index);
            return TripCard(globals.trips[key]);
          },
        ),
      ),
    );
  }

  Widget TripCard(trip) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripDetails(trip: trip)),
        )
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        globals.users[trip["driverUserId"]]["image"]),
                  ),
                  title: Text(
                    '${globals.users[trip["driverUserId"]]["name"]}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text('Driver'),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      '${trip["startLocation"]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${trip["departureDateTime"]}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Icon(Icons.arrow_forward_rounded),
                    contentPadding: EdgeInsets.all(-15),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      '${trip["destination"]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      ('${trip["arrivalDateTime"]}' == "null")
                          ? ""
                          : '${trip["arrivalDateTime"]}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Seats Available',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${trip["availableSeats"]}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Cost',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${trip["passengerCost"]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
