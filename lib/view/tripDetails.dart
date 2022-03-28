import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:passenger/view/findTripFilter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key}) : super(key: key);
  @override
  _TripDetailsState createState(){
    return _TripDetailsState();
  }
}

class _TripDetailsState extends State<TripDetails> {

  final _formKey = GlobalKey<FormState>();
  final isDriver = true;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FindTripFilter()),
              );
            } : null,
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
              child:
                ListView(
                  children: <Widget>[
                    trip("hello"),
                    inputText("Driver"),
                    inputDateTime("Departure Date/Time"),
                    inputDateTime("Arrival Date/Time"),
                    Text("Flexible Departure Date?"),
                    DropdownButton<String>(
                      items: <String>['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      style:TextStyle(color:Colors.blue, fontSize: 16),
                      isExpanded: true,
                    ),
                    Text("Are you willing to drive?"),
                    DropdownButton<String>(
                      items: <String>['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      style:TextStyle(color:Colors.blue, fontSize: 16),
                      isExpanded: true,
                    ),
                    Text("Seats Available?"),
                    DropdownButton<String>(
                      items: <String>['1', '2', '3', '4', '5', '6'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      style:TextStyle(color:Colors.blue, fontSize: 16),
                      isExpanded: true,
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 300.0,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11.0,
                        ),
                      ),
                    ),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget trip(String label) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
        child: Text(
          "Location"
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
        child: Icon(Icons.arrow_right_alt_sharp),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
        child: Text(
          "Location"
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

Widget inputText(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15),
    child: TextFormField(
      decoration: InputDecoration(labelText: label),
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