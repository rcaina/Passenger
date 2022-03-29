import 'package:flutter/material.dart';
import 'package:passenger/view/createTrip.dart';
import 'package:passenger/globals.dart' as globals;
// import 'package:passenger/view/tripcard.dart';

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
          itemCount: globals.myTrips.length,
          itemBuilder: (context, index) {
            return TripCard(globals.myTrips[index]);
          },
        ),
      ),
    );
  }

  Widget TripCard(trip) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // const ListTile(
            //   leading: CircleAvatar(
            //     backgroundImage:
            //     NetworkImage('https://i.redd.it/v0caqchbtn741.jpg'),
            //   ),
            //   title: Text('Brian Stokes'),
            //   subtitle: Text('Driver'),
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://i.redd.it/v0caqchbtn741.jpg'),
                  ),
                  title: Text('Brian Stokes'),
                  subtitle: Text('Driver'),
                  trailing: ClipRRect(
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
                    ),
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Start'),
                    subtitle: const Text('Date'),
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
                    title: const Text('Destination'),
                    subtitle: const Text('Date'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Seats Available'),
                    subtitle: const Text('Number'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Cost'),
                    subtitle: const Text('Money'),
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
