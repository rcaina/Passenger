import 'package:flutter/material.dart';
import 'package:passenger/view/createTrip.dart';
import 'package:passenger/view/tripDetails.dart';
import 'package:passenger/globals.dart' as globals;
// import 'package:passenger/view/tripcard.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({Key? key, this.userId = 0}) : super(key: key);
  final int userId;
  @override
  _MyTripsState createState() => _MyTripsState(this.userId);
}

class _MyTripsState extends State<MyTrips> {
  int userId;
  _MyTripsState(this.userId);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> trips = Map<String, dynamic>();

    for (var item in globals.trips.entries) {
      if (('${globals.users[item.value["driverUserId"]]["name"]}' ==
          '${globals.users[globals.currentUserId]["name"]}')) {
        trips.putIfAbsent(item.key, () => item.value);
        continue;
      }
      for (dynamic passenger in item.value["passengers"]) {
        if (passenger["name"] ==
            '${globals.users[globals.currentUserId]["name"]}') {
          trips.putIfAbsent(item.key, () => item.value);
          continue;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateTrip()),
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
            return TripCard(trips[key]);
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
                      backgroundImage: NetworkImage(
                          globals.users[trip["driverUserId"]]["imageURL"]),
                    ),
                    title:
                        Text('${globals.users[trip["driverUserId"]]["name"]}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            )),
                    subtitle: Text('Driver'),
                    trailing: statusButton(
                        globals.users[globals.currentUserId]["name"],
                        '${globals.users[trip["driverUserId"]]["name"]}',
                        trip['passengers'][int.parse(globals.currentUserId)]
                            ['status'])),
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
                      '${trip["departureDateTime"]}'.toString(),
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

  Widget statusButton(user, driver, status) {
    return (user != driver)
        ? Container(
            height: 35,
            width: 100,
            child: Card(
              elevation: 4.0,
              child: condition(status),
            ))
        : Container(
            height: 35,
            width: 100,
          );
  }

  Widget condition(status) {
    // other logic
    // Declare a widget variable,
    // it will be assigned later according
    // to the condition
    Widget widget;

    // Using switch statement to display desired
    // widget if any certain condition is met
    // You are free to use any condition
    // For simplicity I have used boolean contition
    switch (status) {
      case "confirmed":
        widget = Center(
            child: Text(
          status,
          style: TextStyle(color: Colors.blue),
        ));
        break;
      case "denied":
        widget = Center(
            child: Text(
          status,
          style: TextStyle(color: Colors.red),
        ));
        break;
      case "requested":
        widget = Center(
            child: Text(
          status,
          style: TextStyle(color: Colors.yellow),
        ));
        break;
      default:
        widget = Container(
          height: 35,
          width: 100,
        );
    }

    // Finally returning a Widget
    return widget;
  }

  // Widget TripCard1(trip) {
  //   return Center(
  //     child: Card(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //             Expanded(
  //               child: ListTile(
  //                   leading: CircleAvatar(
  //                     backgroundImage:
  //                         NetworkImage('https://i.redd.it/v0caqchbtn741.jpg'),
  //                   ),
  //                   title: Text(
  //                     '${globals.users[trip["driverUserId"]]["name"]}',
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       color: Colors.blue,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   subtitle: Text('Driver'),
  //                   trailing: statusButton(
  //                       globals.users[globals.currentUserId]["name"],
  //                       '${globals.users[trip["driverUserId"]]["name"]}',
  //                       status)),
  //             ),
  //           ]),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Expanded(
  //                 child: ListTile(
  //                   title: Text(
  //                     '${trip["startLocation"]}',
  //                     style: TextStyle(
  //                       fontSize: 12.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   subtitle: Text(
  //                     '${trip["departureDateTime"]}'.toString(),
  //                     style: TextStyle(
  //                       fontSize: 10.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: ListTile(
  //                   title: Icon(Icons.arrow_forward_rounded),
  //                   contentPadding: EdgeInsets.all(-15),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: ListTile(
  //                   title: Text(
  //                     '${trip["destination"]}',
  //                     style: TextStyle(
  //                       fontSize: 12.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   subtitle: Text(
  //                     '${trip["arrivalDateTime"]}',
  //                     style: TextStyle(
  //                       fontSize: 10.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   contentPadding: EdgeInsets.all(0),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: ListTile(
  //                   title: Text(
  //                     'Seats Available',
  //                     style: TextStyle(
  //                       fontSize: 12.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   subtitle: Text(
  //                     '${trip["availableSeats"]}',
  //                     style: TextStyle(
  //                       fontSize: 10.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   contentPadding: EdgeInsets.all(0),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: ListTile(
  //                   title: Text(
  //                     'Cost',
  //                     style: TextStyle(
  //                       fontSize: 12.0,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   subtitle: Text(
  //                     '${trip["passengerCost"]}',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   contentPadding: EdgeInsets.all(0),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
