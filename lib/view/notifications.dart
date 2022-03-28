import 'package:flutter/material.dart';

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
        child: ListView(
          children:[
            notificationCard(context)
          ]
        ),
      ),
    );
  }

  Widget notificationCard(BuildContext context) {
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
                  TextSpan(text: 'Andrew Smith', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' has confirmed your request to ride with them.'),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
