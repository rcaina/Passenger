import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:passenger/network/server_facade.dart';
import 'package:uuid/uuid.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:passenger/view/navigation.dart';
import 'package:passenger/globals.dart' as globals;

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

  final startLocationController = TextEditingController();
  final destinationController = TextEditingController();
  final departureDateTimeController = TextEditingController();
  final availableSeatsController = TextEditingController();
  final passengerCostController = TextEditingController();
  final _controller = TextEditingController();

  final Map<String, int> carTypesMPG = {"Sedan": 30, "SUV": 26, "Truck": 22};
  String? carType;
  String tripCost = "";

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
                  inputLocation("Start Location", startLocationController),
                  inputLocation("Destination", destinationController),
                  inputDateTime(
                      "Departure Date/Time", departureDateTimeController),
                  inputNumber("Available Seats", availableSeatsController),
                  dropdownCarType(),
                  estimateTripCostButton(),
                  inputNumber("Passenger Cost", passengerCostController),
                  buttonCreateTrip(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get textDescription {
    return const Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        "Once you create a trip, others seeking a driver will request to join you.",
        textAlign: TextAlign.center,
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

  Widget inputDollarAmount(String label, controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixText: '\$ ',
        ),
        controller: controller,
      ),
    );
  }

  Widget dropdownCarType() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: DropdownButton<String>(
        value: carType,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 24,
        style: const TextStyle(color: Colors.blue, fontSize: 16),
        isExpanded: true,
        hint: Text("Select Car Type"),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (String? newValue) {
          setState(() {
            carType = newValue!;
          });
        },
        items: carTypesMPG.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget estimateTripCostButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 15),
          child: SizedBox(
            width: 100, // specific value
            child: RaisedButton(
              child: Text(
                "Estimate Trip Cost",
                style: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                if (startLocationController.text.isEmpty ||
                    destinationController.text.isEmpty) {
                  setState(() {
                    tripCost =
                        "Please enter your start location and destination";
                  });
                } else {
                  ServerFacade.getDistanceBetweenTwoCities(
                          startLocationController.text,
                          destinationController.text)
                      .then((response) {
                    print(response);
                    var GAS_PRICE = 4.4;
                    var distance =
                        response["rows"][0]["elements"][0]["distance"]["text"];
                    var travelTime =
                        response["rows"][0]["elements"][0]["duration"]["text"];
                    var distanceValue =
                        distance.replaceAll(RegExp(r'[^0-9]'), '');
                    var mpg = carType != null
                        ? carTypesMPG[carType]
                        : carTypesMPG["Sedan"];
                    var cost = (int.parse(distanceValue) / mpg! * GAS_PRICE)
                        .toStringAsFixed(2);

                    if (availableSeatsController.text.isNotEmpty) {
                      passengerCostController.text = (double.parse(cost) /
                              (int.parse(availableSeatsController.text) + 1))
                          .toStringAsFixed(2);
                    }

                    setState(() {
                      tripCost = "Travel Time: " +
                          travelTime +
                          "\nTrip Distance: " +
                          distance +
                          "\nEstimated Trip Cost: \$" +
                          cost;
                    });
                  }, onError: (error) {
                    print(error);
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Text(tripCost),
        ),
      ],
    );
  }

  Widget buttonCreateTrip(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: ButtonTheme(
        height: 60,
        minWidth: 170,
        child: RaisedButton(
          child: const Text('Create Trip',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          color: Colors.blue,
          onPressed: () {
            Map<String, dynamic> trip = {
              'id': Uuid().v4(),
              'driver': globals.user,
              'startLocation': startLocationController.text,
              'destination': destinationController.text,
              'departureDateTime': departureDateTimeController.text,
              'availableSeats': availableSeatsController.text,
              'passengerCost': passengerCostController.text,
              'passengers': []
            };
            globals.myTrips.add(trip);
            globals.trips.add(trip);
            print("My Trips: " + globals.myTrips.toString());
            print("Trips: " + globals.trips.toString());

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navigation()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
