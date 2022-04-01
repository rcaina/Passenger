import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:passenger/view/findTripFilter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/view/mapWidget.dart';

class TripDetails extends StatefulWidget {
  const TripDetails(
      {Key? key,
      this.trip,
      this.start = "",
      this.destination = "",
      this.driver = "",
      this.departureInfo = "",
      this.arrivalInfo = "",
      this.seatsAvailable = "",
      this.passengers = const [],
      this.userId = 0})
      : super(key: key);
  final String start;
  final String destination;
  final String driver;
  final String departureInfo;
  final String arrivalInfo;
  final String seatsAvailable;
  final List<dynamic> passengers;
  final int userId;
  final dynamic trip;

  @override
  _TripDetailsState createState() => _TripDetailsState(
      this.trip,
      this.start,
      this.destination,
      this.driver,
      this.departureInfo,
      this.arrivalInfo,
      this.seatsAvailable,
      this.passengers,
      this.userId);
}

class _TripDetailsState extends State<TripDetails> {
  String start;
  String destination;
  String driver;
  String departureInfo;
  String arrivalInfo;
  String seatsAvailable;
  List<dynamic> passengers;
  int userId;
  dynamic trip;

  _TripDetailsState(
      this.trip,
      this.start,
      this.destination,
      this.driver,
      this.departureInfo,
      this.arrivalInfo,
      this.seatsAvailable,
      this.passengers,
      this.userId);

  final _formKey = GlobalKey<FormState>();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool edit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trip Details"),
        actions: this.driver == globals.users[globals.currentUserId]["name"]
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.mode_edit),
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FindTripFilter()),
                    // );
                  },
                ),
              ]
            : null,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
                  child: locations(this.start, this.destination),
                ),
                inputText("Driver", this.driver),
                inputText("Departure Date/Time", this.departureInfo),
                inputText("Arrival Date/Time", this.arrivalInfo),
                inputText("Seats Available", this.seatsAvailable),
                inputText("Passengers", "- Luke Johnson"),
                updateButton(),
                MapWidget(trip),
              ],
            ),
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
              setState(() {
                edit = !edit;
              });
            },
          )
        : Container();
  }

  Widget locations(String start, String destination) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
          child: Text(
            start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
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

  Widget _buildGoogleMap() {
    final LatLng _center = const LatLng(45.521563, -122.677433);

    return Positioned(
      left: 50,
      right: 30,
      top: 100,
      bottom: 300,
      child: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }

  Widget inputText(String label, String info) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: globals.users[globals.currentUserId]["name"] == this.driver
          ? TextFormField(
              enabled: !edit,
              decoration: InputDecoration(labelText: label),
              initialValue: (info == "null") ? "" : info,
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

  Widget listPassengers(String label, List<dynamic> passengers) {
    List<dynamic> passengerList = [];
    for (dynamic passenger in passengers) {
      if (passenger["status"] == "requested") {
        passengerList.add(passenger);
      }
    }
    print(passengers);
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: passengerList.length,
            itemBuilder: (BuildContext context, int index) {
              print(passengerList[index]);
              return Text(passengerList[index]);
            }));
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
