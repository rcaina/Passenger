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
          itemCount: globals.trips.length,
          itemBuilder: (context, index) {
            String key = globals.trips.keys.elementAt(index);
            print(globals.trips[key]);
            //return Text("hey " + key);
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
          MaterialPageRoute(
              builder: (context) => TripDetails(
                    start: '${trip["startLocation"]}',
                    destination: '${trip["destination"]}',
                    driver: '${globals.users[trip["driverUserId"]]["name"]}',
                    departureInfo: '${trip["departureDateTime"]}',
                    arrivalInfo: '${trip["arrivalDateTime"]}',
                    seatsAvailable: '${trip["passengers"]}',
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
                      backgroundImage:
                          NetworkImage('https://i.redd.it/v0caqchbtn741.jpg'),
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
                        '${globals.users[trip["driverUserId"]]["name"]}')),
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
                      '${trip["departureDateTime"]}',
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

  Widget statusButton(user, driver) {
    print(user);
    print(driver);
    return user != driver
        ? ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {},
                  child: const Text('Approved'),
                ),
              ],
            ))
        : Container();
  }

  Widget TripCard1(trip) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.redd.it/v0caqchbtn741.jpg'),
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
                    trailing: statusButton(
                        globals.users[globals.currentUserId]["name"],
                        '${globals.users[trip["driverUserId"]]["name"]}')),
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
                      '${trip["departureDateTime"]}',
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
