import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:passenger/view/findTripFilter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/globals.dart' as globals;

class TripDetails extends StatefulWidget {
  const TripDetails(
      {Key? key,
      this.start = "",
      this.destination = "",
      this.driver = "",
      this.departureInfo = "",
      this.arrivalInfo = "",
      this.seatsAvailable = "",
      this.userId = 0})
      : super(key: key);
  final String start;
  final String destination;
  final String driver;
  final String departureInfo;
  final String arrivalInfo;
  // final String flexibleDeparture;
  final String seatsAvailable;
  final int userId;

  @override
  _TripDetailsState createState() => _TripDetailsState(
      this.start,
      this.destination,
      this.driver,
      this.departureInfo,
      this.arrivalInfo,
      this.seatsAvailable,
      this.userId);
}

class _TripDetailsState extends State<TripDetails> {
  String start;
  String destination;
  String driver;
  String departureInfo;
  String arrivalInfo;
  String seatsAvailable;
  int userId;

  _TripDetailsState(this.start, this.destination, this.driver,
      this.departureInfo, this.arrivalInfo, this.seatsAvailable, this.userId);

  final _formKey = GlobalKey<FormState>();
  final isDriver = true;
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.mode_edit),
            onPressed: isDriver
                ? () {
                    if (edit) {
                      setState(() {
                        edit = false;
                      });
                    } else {
                      setState(() {
                        edit = true;
                      });
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FindTripFilter()),
                    // );
                  }
                : null,
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  trip(this.start, this.destination),
                  inputText("Driver", this.driver),
                  inputText("Departure Date/Time", this.departureInfo),
                  inputText("Arrival Date/Time", this.arrivalInfo),
                  Text("Flexible Departure Date?"),
                  DropdownButton<String>(
                    items: <String>['Yes', 'No'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    isExpanded: true,
                  ),
                  // Text("Are you willing to drive?"),
                  // DropdownButton<String>(
                  //   items: <String>['Yes', 'No'].map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (_) {},
                  //   style:TextStyle(color:Colors.blue, fontSize: 16),
                  //   isExpanded: true,
                  // ),
                  inputText("Seats Available", this.seatsAvailable),
                  updateButton(),
                  // DropdownButton<String>(
                  //   items: <String>['1', '2', '3', '4', '5', '6']
                  //       .map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (_) {},
                  //   style: TextStyle(color: Colors.blue, fontSize: 16),
                  //   isExpanded: true,
                  // ),
                  // SizedBox(
                  //   width: 200.0,
                  //   height: 300.0,
                  //   child: GoogleMap(
                  //     mapType: MapType.normal,
                  //     initialCameraPosition: CameraPosition(
                  //       target: _center,
                  //       zoom: 11.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
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
              if (edit) {
                setState(() {
                  edit = false;
                });
              } else {
                setState(() {
                  edit = true;
                });
              }
            },
          )
        : Container();
  }

  Widget trip(String start, String destination) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
          child: Text(start),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
          child: Icon(Icons.arrow_right_alt_sharp),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
          child: Text(destination),
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
      child: globals.users[userId]["name"] != this.driver
          ? TextFormField(
              enabled: !edit,
              decoration: InputDecoration(labelText: label),
              initialValue: info,
            )
          : ListTile(
              title: Text(
                label,
              ),
              subtitle: Text(
                info,
              ),
              contentPadding: EdgeInsets.all(0),
            ),
    );
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
