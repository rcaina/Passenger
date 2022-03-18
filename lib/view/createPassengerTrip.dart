import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'navigation.dart';

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
                  inputText("Start Location"),
                  inputText("Destination"),
                  inputDateTime("Departure Date/Time"),
                  inputDateTime("Arrival Date/Time"),
                  buttonFindTrips(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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

Widget buttonFindTrips(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 25, bottom: 25),
    child: ButtonTheme(
      height: 50,
      child: RaisedButton(
          child: const Text('Find Trips',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Navigation(initialSelectedIndex: 1)),
              (route) => false,
            );
          }),
    ),
  );
}
