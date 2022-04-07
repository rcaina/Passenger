import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/network/server_facade.dart';
import 'package:passenger/view/mapWidget.dart';
import 'package:passenger/view/profile.dart';
import 'package:passenger/view/tripDetails.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key, required this.request}) : super(key: key);

  final dynamic request;

  @override
  State<StatefulWidget> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  dynamic request;
  String timeAddedToRoute = "";
  String distanceAddedToRoute = "";
  dynamic currentTrip, newTrip;

  @override
  void initState() {
    super.initState();
    request = widget.request;
    request["read"] = true;
    currentTrip = globals.trips[request["tripId"]];
    newTrip = jsonDecode(jsonEncode(currentTrip));
    for (var i = 0; i < newTrip["passengers"].length; i++) {
      if (newTrip["passengers"][i]["userId"] == request["passengerId"]) {
        newTrip["passengers"][i]["status"] = "confirmed";
      }
    }
    calculateTimeAddedToRoute(currentTrip, newTrip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(""),
          Title(
            color: Colors.black,
            child: Text(
              "Requester",
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 25,
              ),
            ),
          ),
          requesterCard(request["passengerId"]),
          messageButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [acceptButton(), rejectButton()],
          ),
        ],
      ),
    );
  }

  Widget requesterCard(String userId) {
    dynamic user = globals.users[userId];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(user["image"]),
                    ),
                    title: Text(user["name"],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text("Passenger"),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(
                                    userId: userId,
                                  )));
                    },
                    child: Text("View Profile"),
                    style: TextButton.styleFrom(
                        primary: Colors.blue,
                        side: BorderSide(width: 1.0, color: Colors.blue)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: ListTile(
                  title: Center(
                    child: Text(newTrip["startLocation"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  subtitle: Center(
                    child: Text(newTrip["departureDateTime"]),
                  ),
                )),
                SizedBox(
                  width: 35,
                  child: ListTile(
                      title: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.green,
                  )),
                ),
                Expanded(
                    child: ListTile(
                  title: Center(
                    child: Text(request["passengerDestination"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  subtitle: Center(
                    child: Text(newTrip["arrivalDateTime"]),
                  ),
                )),
              ],
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Added Time: ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    timeAddedToRoute,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Added Distance: ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    distanceAddedToRoute,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contribution: ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${request["passengerContribution"].toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "New Route with ${request["passengerDestination"]}:",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            MapWidget(newTrip),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget messageButton() {
    return ElevatedButton(
        onPressed: () {
          String phoneNumber = globals.users[request["passengerId"]]["phone"];
          print(phoneNumber);
          _launchMessages(phoneNumber);
        },
        child: Text("Message"));
  }

  Widget acceptButton() {
    return ElevatedButton(
        onPressed: () {
          var requestId = globals.requests.keys.firstWhere(
              (k) => globals.requests[k] == request,
              orElse: () => "");

          if (requestId == "") {
          } else {
            Map<String, dynamic> requestResponse = {
              "requestId": requestId,
              "addedToTrip": true,
              "read": false,
            };

            String requestResponseId = Uuid().v4();
            globals.requestResponses
                .addAll({requestResponseId: requestResponse});

            var passengerId = request["passengerId"];

            var passengerIndex = globals.trips[request["tripId"]]["passengers"]
                .indexWhere((passenger) => passenger["userId"] == passengerId);

            globals.trips[request["tripId"]]["passengers"][passengerIndex]
                .update("status", (status) => "confirmed");
            globals.trips[request["tripId"]]["availableSeats"]--;
          }
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripDetails(
                      trip: globals.trips[request["tripId"]],
                      tripId: "-1",
                      addRequestButton: false)));
        },
        child: Text("Accept"),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.green,
            side: BorderSide(width: 1.0, color: Colors.green)));
  }

  Widget rejectButton() {
    return ElevatedButton(
        onPressed: () {
          var requestId = globals.requests.keys.firstWhere(
              (k) => globals.requests[k] == request,
              orElse: () => "");

          if (requestId == "") {
          } else {
            Map<String, dynamic> requestResponse = {
              "requestId": requestId,
              "addedToTrip": true,
              "read": false,
            };

            String requestResponseId = Uuid().v4();
            globals.requestResponses
                .addAll({requestResponseId: requestResponse});

            var passengerId = request["passengerId"];

            globals.trips[request["tripId"]]["passengers"]
                .removeWhere((passenger) => passenger["userId"] == passengerId);
          }
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripDetails(
                      trip: globals.trips[request["tripId"]],
                      tripId: "-1",
                      addRequestButton: false)));
        },
        child: Text("Reject"),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.red,
            side: BorderSide(width: 1.0, color: Colors.red)));
  }

  calculateTimeAddedToRoute(currentTrip, newTrip) {
    String currentTripWaypoints = getWaypoints(currentTrip["passengers"]);
    String newTripWaypoints = getWaypoints(newTrip["passengers"]);
    ServerFacade.getDirections(currentTrip["startLocation"],
            currentTrip["destination"], currentTripWaypoints)
        .then((route) {
      int currentDistance = 0;
      int currentDuration = 0;
      for (var leg in route["legs"]) {
        currentDistance += leg["distance"]["value"] as int;
        currentDuration += leg["duration"]["value"] as int;
      }

      ServerFacade.getDirections(newTrip["startLocation"],
              newTrip["destination"], newTripWaypoints)
          .then((newRoute) {
        var newDistance = 0;
        var newDuration = 0;
        for (var leg in newRoute["legs"]) {
          newDistance += leg["distance"]["value"] as int;
          newDuration += leg["duration"]["value"] as int;
        }
        int distanceAdded = newDistance - currentDistance;
        int durationAdded = newDuration - currentDuration;

        int hours = (durationAdded / 3600).floor();
        int minutes = ((durationAdded % 3600) / 60).round();

        timeAddedToRoute = hours > 0 ? hours.toString() + " hrs, " : "";
        timeAddedToRoute += minutes.toString() + " mins";

        const kmPerMi = 1609.34;
        distanceAddedToRoute =
            (distanceAdded / kmPerMi).toStringAsFixed(1) + " miles";
        setState(() {});
      });
    });
  }

  getWaypoints(passengers) {
    String waypoints = "";
    for (dynamic passenger in passengers) {
      if (passenger["status"] == "confirmed") {
        waypoints += passenger["destination"] + "|";
      }
    }
    return waypoints;
  }

  void _launchMessages(String phoneNumber) async {
    var uri = 'sms:+91888888888';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch messages for phone number: $uri';
    }
  }
}
