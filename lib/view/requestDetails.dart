import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/network/server_facade.dart';
import 'package:passenger/view/mapWidget.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  dynamic request = globals.requests["0"];
  String timeAddedToRoute = "";
  String distanceAddedToRoute = "";
  dynamic currentTrip, newTrip;

  @override
  void initState() {
    super.initState();
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
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Text(""),
            Title(
                color: Colors.black,
                child: Text("Requester",
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 25,
                    ))),
            requesterCard(globals.users[request["passengerId"]]),
            Text("Estimated Time Added to Trip: " + timeAddedToRoute),
            Text("Estimated Distance Added to Trip: " + distanceAddedToRoute),
            Text("New Route with ${request["passengerDestination"]}:"),
            MapWidget(newTrip),
          ]),
        ));
  }

  Widget requesterCard(dynamic user) {
    return Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(
          children: [
            Text("  "),
            CircleAvatar(
              backgroundImage: AssetImage(user["image"]),
              radius: 20.0,
            ),
            Text("  "),
            Column(
              children: [Text(user["name"]), Text("(Passenger)")],
            ),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("View Profile"))
          ],
        ),
      ]),
    );
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

        timeAddedToRoute =
            hours.toString() + " hrs, " + minutes.toString() + " mins";

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
}
