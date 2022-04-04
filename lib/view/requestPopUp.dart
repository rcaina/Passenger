import 'package:flutter/material.dart';
import 'package:passenger/view/profile.dart';
import 'package:settings_ui/settings_ui.dart';

class RequestPopUp extends StatefulWidget {
  const RequestPopUp({Key? key}) : super(key: key);
  @override
  _RequestPopUpState createState() => _RequestPopUpState();
}

class _RequestPopUpState extends State<RequestPopUp> {
  int group1 = 1;
  int group2 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Information"),
      ),
      body: AlertDialog(
        // title: const Text('Request Information'),
        content: Padding(
            padding: const EdgeInsets.all(25),
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
                      ]),
                      Row(children: <Widget>[
                        Radio<int>(
                            value: 3,
                            groupValue: group1,
                            onChanged: (value) {
                              setState(() {
                                group1 = value!;
                              });
                            }),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 15.0),
                        ),
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
              Navigator.of(context).pop();
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
    return Container(
        padding: const EdgeInsets.all(0.0),
        color: Colors.white,
        child: Container(
          child: Center(
              child: Column(children: [
            Padding(padding: EdgeInsets.only(top: 0.0)),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Optional Message",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              // style: TextStyle(
              //   fontFamily: "Poppins",
              // ),
            ),
          ])),
        ));
  }
}
