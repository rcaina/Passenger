import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:passenger/view/navigation.dart';

class CreatePassengerTrip extends StatefulWidget {
  const CreatePassengerTrip({Key? key}) : super(key: key);

  @override
  _CreatePassengerTripState createState() {
    return _CreatePassengerTripState();
  }
}

class _CreatePassengerTripState extends State<CreatePassengerTrip> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final startLocationController = TextEditingController();
  final destinationController = TextEditingController();
  final departureDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desired Trip'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  inputLocation("Start Location", startLocationController),
                  inputLocation("Destination", destinationController),
                  inputDateTime(
                      "Departure Date/Time", departureDateTimeController),
                  buttonFindTrips(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputLocation(String label, controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: RaisedButton(
            onPressed: () {
              controller.text = "BYU, Provo, UT";
            },
            textColor: Colors.black,
            child: Column(
              children: <Widget>[
                Icon(Icons.my_location),
                Text('Use Current Location', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget inputDateTime(String label, controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: label,
        onChanged: (val) => {controller.text = val},
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => {controller.text = val},
      ),
    );
  }

  Widget buttonFindTrips(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: ButtonTheme(
        height: 60,
        minWidth: 170,
        child: RaisedButton(
          child: const Text('Find Trips',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          color: Colors.blue,
          onPressed: () {
            Map<String, dynamic> desiredTrip = {
              'startLocation': startLocationController.text,
              'destination': destinationController.text,
              'departureDateTime': departureDateTimeController.text
            };
            print(desiredTrip);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Navigation(initialSelectedIndex: 1)),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
