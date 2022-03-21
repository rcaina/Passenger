import 'package:flutter/material.dart';

class FindTripFilter extends StatefulWidget {
  const FindTripFilter({Key? key}) : super(key: key);
  @override
  _FindTripFilterState createState(){
    return _FindTripFilterState();
  }
}

class _FindTripFilterState extends State<FindTripFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Filter',
            ),
          ],
        ),
      ),
    );
  }
}
