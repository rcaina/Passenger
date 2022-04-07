import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/view/requestDetails.dart';
import 'package:passenger/view/tripDetails.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> notifications = getNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            String key = notifications.keys.elementAt(index);
            return notificationCard(notifications[key]);
          },
        ),
      ),
    );
  }

  Widget notificationCard(dynamic notification) {
    var trip = globals.trips[notification["tripId"]];
    var request = globals.requests[notification["requestId"]];
    return GestureDetector(
        onTap: () => {
              if (notification["notificationType"] == "request")
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RequestDetails(request: request)))
                }
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripDetails(
                              trip: trip,
                              tripId: "-1",
                              addRequestButton: false)))
                }
            },
        child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(notification["userImage"]),
                      radius: 20.0,
                    ),
                    title: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: notification["userName"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: notification["message"]),
                        ],
                      ),
                    )),
                Row(
                  children: [Text("")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(notification["startLocation"]),
                        Text(notification["departureDateTime"]),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(notification["destination"]),
                        Text(notification["arrivalDateTime"]),
                      ],
                    )
                  ],
                ),
              ],
            )));
  }

  Map<String, dynamic> getNotifications() {
    Map<String, dynamic> notifications = <String, dynamic>{};
    for (var request in globals.requests.entries) {
      if (('${globals.trips[request.value["tripId"]]["driverUserId"]}' ==
          globals.currentUserId)) {
        var user = globals.users[request.value["passengerId"]];
        var trip = globals.trips[request.value["tripId"]];

        notifications.putIfAbsent(
            request.key,
            () => {
                  "notificationType": "request",
                  "requestId": request.key,
                  "userName": user["name"],
                  "userImage": user["image"],
                  "message": " has requested to join your ride.",
                  "tripId": request.value["tripId"],
                  "read": request.value["read"],
                  "startLocation": trip["startLocation"],
                  "destination": trip["destination"],
                  "departureDateTime": trip["departureDateTime"],
                  "arrivalDateTime": trip["arrivalDateTime"]
                });
      }
    }

    for (var response in globals.requestResponses.entries) {
      var request = globals.requests[response.value["requestId"]];

      if (request["passengerId"] == globals.currentUserId) {
        var trip = globals.trips[request["tripId"]];
        var user = globals.users[trip["driverUserId"]];

        String message;

        if (response.value["addedToTrip"]) {
          message = " has confirmed your request to ride with them.";
        } else {
          message = " has denied your request to ride with them.";
        }

        notifications.putIfAbsent(
            response.value["requestId"],
            () => {
                  "notificationType": "response",
                  "requestId": response.value["requestId"],
                  "userName": user["name"],
                  "userImage": user["image"],
                  "message": message,
                  "tripId": request["tripId"],
                  "read": request["read"],
                  "startLocation": trip["startLocation"],
                  "destination": trip["destination"],
                  "departureDateTime": trip["departureDateTime"],
                  "arrivalDateTime": trip["arrivalDateTime"]
                });
      }
    }
    return notifications;
  }
}
