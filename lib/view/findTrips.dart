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
    Map<String, dynamic> trips = Map<String, dynamic>();
    for (var item in globals.trips.entries) {
      if (('${globals.users[item.value["driverUserId"]]["name"]}' !=
              '${globals.users[globals.currentUserId]["name"]}') &&
          (item.value["passengers"].length < item.value["availableSeats"])) {
        trips.putIfAbsent(item.key, () => item.value);
      }
    }

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
          itemCount: trips.length,
          itemBuilder: (context, index) {
            String key = trips.keys.elementAt(index);
            return TripCard(trips[key], key);
          },
        ),
      ),
    );
  }

  Widget TripCard(trip, key) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TripDetails(
                    trip: trip,
                    tripId: key,
                    addRequestButton: true,
                  )),
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
                    trailing: Text(
                        "Seats Available: " + trip["availableSeats"].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15))),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      trip["startLocation"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      trip["departureDateTime"],
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.green,
                      size: 35,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      trip["destination"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      trip["arrivalDateTime"],
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            Text(""),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Expanded(
            //       child: ListTile(
            //         title: Text(
            //           '${trip["startLocation"]}',
            //           style: TextStyle(
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         subtitle: Text(
            //           '${trip["departureDateTime"]}',
            //           style: TextStyle(
            //             fontSize: 10.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: ListTile(
            //         title: Icon(Icons.arrow_forward_rounded),
            //         contentPadding: EdgeInsets.all(-15),
            //       ),
            //     ),
            //     Expanded(
            //       child: ListTile(
            //         title: Text(
            //           '${trip["destination"]}',
            //           style: TextStyle(
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         subtitle: Text(
            //           ('${trip["arrivalDateTime"]}' == "null")
            //               ? ""
            //               : '${trip["arrivalDateTime"]}',
            //           style: TextStyle(
            //             fontSize: 10.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         contentPadding: EdgeInsets.all(0),
            //       ),
            //     ),
            //     Expanded(
            //       child: ListTile(
            //         title: Text(
            //           'Seats Available',
            //           style: TextStyle(
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         subtitle: Text(
            //           '${trip["availableSeats"]}',
            //           style: TextStyle(
            //             fontSize: 10.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         contentPadding: EdgeInsets.all(0),
            //       ),
            //     ),
            //     Expanded(
            //       child: ListTile(
            //         title: Text(
            //           'Cost',
            //           style: TextStyle(
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         subtitle: Text(
            //           '${trip["passengerCost"]}',
            //           style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         contentPadding: EdgeInsets.all(0),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
