import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.userId = "driver-0"}) : super(key: key);

  final String userId;

  @override
  _ProfileState createState() => _ProfileState(this.userId);
}

class _ProfileState extends State<Profile> {
  String userId;
  _ProfileState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: CircleAvatar(
                backgroundImage: AssetImage(globals.users[userId]["image"]),
                radius: 80.0,
              ),
            ),
            Text(
              globals.users[userId]["name"],
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 25,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: Text('Phone'),
                          subtitle: Text(globals.users[userId]["phone"]),
                          trailing: ElevatedButton(
                            child: Text("Message"),
                            onPressed: () {
                              _launchMessages(globals.users[userId]["phone"]);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('About'),
                          subtitle: Text(globals.users[userId]["about"]),
                        ),
                        ListTile(
                          title: Text('Interests'),
                          subtitle: Text(globals.users[userId]["interests"]),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
