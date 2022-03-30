import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:passenger/view/requestDetails.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final requests = globals.requests;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: globals.notifications.length,
          itemBuilder: (context, index) {
            return notificationCard(globals.notifications[index]);
          },
        ),
      ),
    );
  }

  Widget notificationCard(dynamic notification) {
    /*
    dynamic user, request, trip;
    if(requestOrResponse.containsKey("passengerId")) {
      user = globals.users[requestOrResponse["passengerId"]];
    } else {
      request = globals.requests[requestOrResponse["requestId"]];
      trip = globals.trips[request["tripId"]];
      user = globals.users[trip["driverUserId"]];
    }

     */

    dynamic user = globals.users[notification["userId"]];

    var requestMessage = " has requested to join your ride.";
    var acceptedMessage = " has confirmed your request to ride with them.";
    var rejectedMessage = " has denied your request to ride with them.";
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RequestDetails())),
      child: Card(
        elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(user["image"]),
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
                        TextSpan(text: user["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " "),
                        TextSpan(text: notification["message"]),
                      ],
                    ),
                  )
              ),
              Row(
                children: [
                  Text("")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(notification["from-location"]),
                      Text(notification["from-date"]),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.green,)
                    ],
                  ),
                  Column(
                    children: [
                      Text(notification["to-location"]),
                      Text(notification["to-date"]),
                    ],
                  )
                ],
              ),
            ],
          )
      )
    );
  }
}
