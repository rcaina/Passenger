import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerFacade {
  static const String googleMapsDirectionsAPI =
      "https://maps.googleapis.com/maps/api/directions/json";
  static const String googleMapsDistanceMatrixAPI =
      "https://maps.googleapis.com/maps/api/distancematrix/json";

  static String GOOGLE_MAPS_API_KEY = "AIzaSyB-xwiFx0RmrOWmoDjsXHb4cGYbsL4128U";

  static Future<dynamic> getDistanceBetweenTwoCities(
      String start, String destination) async {
    if (start.isNotEmpty && destination.isNotEmpty) {
      var response = await http.get(Uri.parse(googleMapsDistanceMatrixAPI +
          '?origins=' +
          start +
          "&destinations=" +
          destination +
          "&key=" +
          GOOGLE_MAPS_API_KEY +
          "&units=imperial"));
      return jsonDecode(response.body);
    } else {
      return "Missing start or destination";
    }
  }
}
