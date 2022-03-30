import 'package:flutter/material.dart';
import 'package:passenger/globals.dart' as globals;

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(""),
              Title(color: Colors.black,
                  child: Text("Requester", style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ))
              ),
              requesterCard(globals.users["2"]),
            ]
        ),
      )
    );
  }

  Widget requesterCard(dynamic user) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text("  "),
                CircleAvatar(
                  backgroundImage: AssetImage(user["image"]),
                  radius: 20.0,
                ),
                Text("  "),
                Column(
                  children: [
                    Text(user["name"]),
                    Text("(Passenger)")
                  ],
                ),
                Spacer(),
                TextButton(onPressed: (){}, child: Text("View Profile"))
              ],
            ),
          ]
      ),
    );
  }
}