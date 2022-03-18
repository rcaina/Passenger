import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'navigation.dart';

class CreateDriverTrip extends StatefulWidget {
  const CreateDriverTrip({Key? key}) : super(key: key);

  @override
  _CreateDriverTripState createState() {
    return _CreateDriverTripState();
  }
}

class _CreateDriverTripState extends State<CreateDriverTrip> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Trip'),
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
                  textDescription,
                  inputText("Start Location"),
                  inputText("Destination"),
                  inputDateTime("Departure Date/Time"),
                  inputDateTime("Arrival Date/Time"),
                  inputNumber("Available Seats"),
                  inputDollarAmount("Cost per Passenger"),
                  buttonCreateTrip(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget get textDescription {
  return const Padding(
    padding: EdgeInsets.only(top: 50, bottom: 50),
    child: Text(
      "Once you create a trip, others seeking a driver will request to join you.",
      textAlign: TextAlign.center,
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

Widget inputNumber(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15),
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    ),
  );
}

Widget inputDollarAmount(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15),
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixText: '\$ ',
      ),
    ),
  );
}

Widget buttonCreateTrip(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 25, bottom: 25),
    child: ButtonTheme(
      height: 50,
      child: RaisedButton(
          child: const Text('Create Trip',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navigation()),
              (route) => false,
            );
          }),
    ),
  );
}
