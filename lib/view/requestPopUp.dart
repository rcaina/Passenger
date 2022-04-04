import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/view/findTrips.dart';
import 'package:passenger/view/navigation.dart';
import 'package:uuid/uuid.dart';

class RequestPopUp extends StatefulWidget {
  const RequestPopUp({Key? key, required this.tripId, required this.cost})
      : super(key: key);
  final String tripId;
  final String cost;
  @override
  _RequestPopUpState createState() =>
      _RequestPopUpState(this.tripId, this.cost);
}

class _RequestPopUpState extends State<RequestPopUp> {
  _RequestPopUpState(this.tripId, this.cost);
  String tripId;
  String cost;
  int group1 = 1;
  int group2 = 1;
  String message = "";
  bool _isLoading = true;
  bool _enabled = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Information"),
      ),
      body: AlertDialog(
        // title: const Text('Request Information'),
        content: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Divider(height: 5.0, color: Colors.black),
                  Text(
                    'Are you willing to pay the requested amount for this trip?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: group1,
                            onChanged: (value) {
                              setState(() {
                                group1 = value!;
                              });
                            }),
                        Text(
                          'Yes',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Radio<int>(
                            value: 2,
                            groupValue: group1,
                            onChanged: (value) {
                              setState(() {
                                group1 = value!;
                              });
                            }),
                        Text(
                          'No',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          "   (Please specify amount below)",
                          style: TextStyle(fontSize: 10.0),
                        )
                      ]),
                    ],
                  ),
                  Text(
                    'If you have a license, are you willing to drive?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: group2,
                            onChanged: (value) {
                              setState(() {
                                group2 = value!;
                              });
                            }),
                        Text(
                          'Yes',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Radio<int>(
                            value: 2,
                            groupValue: group2,
                            onChanged: (value) {
                              setState(() {
                                group2 = value!;
                              });
                            }),
                        Text(
                          'No',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ]),
                    ],
                  ),
                  inputTextBox("Optional Message")
                ])),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              !_enabled ? null : () => setState(() => _isLoading = true);

              if (group1 == 2) {
                cost = "0.00";
              }
              Map<String, dynamic> request = {
                "passengerId": globals.currentUserId.toString(),
                "tripId": tripId,
                "passengerDestination": globals.destination,
                "message": message,
                "passengerContribution": double.parse(cost),
                "status": "requested", // requested, confirmed, or denied
                "read": false,
              };
              globals.requests.addAll({Uuid().v4(): request});

              dynamic passenger = {
                "userId": globals.currentUserId,
                "status": "requested", // requested | confirmed
                "destination": globals.destination
              };
              globals.trips[tripId]["passengers"].add(passenger);

              print("Requests: " + globals.requests.toString());
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Request"),
                    content: Text("Your request was sent succesfully"),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navigation()),
                            (route) => false,
                          );
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: const Text('Request'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget inputTextBox(label) {
    _controller.addListener(() {
      // you need to add listener like this
      setState(() {
        if (_controller.text.isNotEmpty) {
          _enabled = true;
        } else {
          _enabled = false;
        }
      });
    });

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            message = value;
          });
        },
        maxLines: 5,
        decoration: InputDecoration(
          labelText: "Optional Message",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
  }
}
