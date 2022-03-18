import 'package:flutter/material.dart';
import 'package:passenger/view/createPassengerTrip.dart';
import 'package:passenger/view/createDriverTrip.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({Key? key}) : super(key: key);
  @override
  _CreateTripState createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Trip"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('I am a', style: TextStyle(fontSize: 18)),
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: ButtonTheme(
                height: 80,
                minWidth: 200,
                child: RaisedButton(
                  child: const Text('Driver',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateDriverTrip()),
                    );
                  },
                ),
              ),
            ),
            const Text('or', style: TextStyle(fontSize: 18)),
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: ButtonTheme(
                height: 80,
                minWidth: 200,
                child: RaisedButton(
                  child: const Text('Passenger',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePassengerTrip()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
