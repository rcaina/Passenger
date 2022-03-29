import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    final userIndex = globals.users.indexWhere((element) => element["userId"] == notification["userId"]);
    dynamic user = globals.users.elementAt(userIndex);
    return Card(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(notification["from-location"]),
                  Text(notification["from-date"]),
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
    );
  }
}
