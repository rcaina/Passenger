import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class FindTripFilter extends StatefulWidget {
  const FindTripFilter({Key? key}) : super(key: key);
  @override
  _FindTripFilterState createState() {
    return _FindTripFilterState();
  }
}

class _FindTripFilterState extends State<FindTripFilter> {
  final _formKey = GlobalKey<FormState>();

  final startLocationController = TextEditingController();
  final destinationController = TextEditingController();
  final departureDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
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
                  Text("Departure Date Range:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  inputDateTime("From", departureDateTimeController),
                  inputDateTime("To", departureDateTimeController),
                  Text("Max Time Added To Route:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  inputNumber("Max Time", destinationController),
                  buttonUpdate(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputNumber(String label, controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        controller: controller,
      ),
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

  Widget buttonUpdate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: ButtonTheme(
        height: 60,
        minWidth: 170,
        child: RaisedButton(
          child: const Text('Update',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          color: Colors.blue,
          onPressed: () {
            Map<String, dynamic> desiredTrip = {
              'startLocation': startLocationController.text,
              'destination': destinationController.text,
              'departureDateTime': departureDateTimeController.text
            };
            print(desiredTrip);

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
