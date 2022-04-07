import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/view/mapWidget.dart';
import 'package:passenger/view/profile.dart';
import 'package:passenger/view/requestPopUp.dart';

class TripDetails extends StatefulWidget {
  const TripDetails(
      {Key? key,
      required this.trip,
      required this.tripId,
      required this.addRequestButton})
      : super(key: key);
  final dynamic trip;
  final String tripId;
  final bool addRequestButton;

  @override
  _TripDetailsState createState() =>
      _TripDetailsState(this.trip, this.tripId, this.addRequestButton);
}

class _TripDetailsState extends State<TripDetails> {
  _TripDetailsState(this.trip, this.tripId, this.addRequestButton);

  dynamic trip;
  String tripId;
  bool addRequestButton;
  final _formKey = GlobalKey<FormState>();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  int group = 0;
  bool edit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trip Details"),
        actions: globals.users[trip["driverUserId"]]["name"] ==
                globals.users[globals.currentUserId]["name"]
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.mode_edit),
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                ),
              ]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
                child: locations(trip["startLocation"], trip["destination"]),
              ),
              inputText("Driver", globals.users[trip["driverUserId"]]["name"]),
              inputText("Departure Date", trip["departureDateTime"]),
              inputText("Arrival Date", trip["arrivalDateTime"]),
              inputText("Seats Available", '${trip["availableSeats"]}'),
              inputText("Passenger Cost", '${trip["passengerCost"]}'),
              listPassengers("Passengers", trip["passengers"]),
              MapWidget(trip),
              requestButton(),
              updateButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget updateButton() {
    return !edit
        ? RaisedButton(
            child: const Text('Update',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            color: Colors.blue,
            onPressed: () {
              setState(() {});
            },
          )
        : Container();
  }

  Widget requestButton() {
    return addRequestButton
        ? RaisedButton(
            child: const Text('Request',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            color: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => RequestPopUp(
                    tripId: tripId, cost: '${trip["passengerCost"]}'),
              );
            },
          )
        : Container();
  }

  Widget locations(String start, String destination) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
          child: Text(
            start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 15, 0, 30),
          child: Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.blue.shade400,
            size: 35,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
          child: Text(
            destination,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget inputText(label, info) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: globals.users[globals.currentUserId]["name"] ==
              globals.users[trip["driverUserId"]]["name"]
          ? TextFormField(
              enabled: !edit,
              decoration: InputDecoration(labelText: label),
              initialValue: info.toString(),
            )
          : ListTile(
              enabled: edit,
              title: Text(
                label,
              ),
              subtitle: (info == "null") ? Text("") : Text(info),
              contentPadding: EdgeInsets.all(0),
            ),
    );
  }

  Widget listPassengers(label, passengers) {
    List<dynamic> passengerList = [];
    for (dynamic passenger in passengers) {
      if (passenger["status"] == "confirmed") {
        passengerList.add(passenger);
      }
    }
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Passengers:", style: TextStyle(fontSize: 18)),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.only(left: 20),
              itemCount: passengerList.length,
              itemBuilder: (BuildContext context, int index) {
                return RichText(
                  text: TextSpan(
                    text:
                        '- ${globals.users[passengerList[index]["userId"]]["name"]} (${passengerList[index]["destination"]!})',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(
                                  userId: passengerList[index]["userId"])),
                        );
                      },
                  ),
                );
              },
            ),
          ],
        ));
  }

  Widget inputDateTime(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: label,
        onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print(val),
      ),
    );
  }
}
