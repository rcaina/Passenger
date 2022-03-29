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
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/mark.png"),
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
                  TextSpan(text: notification["user-name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " "),
                  TextSpan(text: notification["message"]),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
