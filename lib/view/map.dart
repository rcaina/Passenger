import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/globals.dart' as globals;

import 'dart:async';

import 'package:passenger/network/server_facade.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

// Markers to show points on the map
Map<MarkerId, Marker> markers = {};
List<PointLatLng> polylinePoints = [];
Map<PolylineId, Polyline> polylines = {};

class _MapViewState extends State<MapView> {
  PolylinePoints polylinePoints = PolylinePoints();
  late GoogleMapController mapController;

  CameraPosition initialLocation = CameraPosition(
    target: LatLng(40, -100),
    zoom: 3.5,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initial location of the Map view

    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Clear Map"),
              onPressed: () {
                clearMap();
              },
            ),
            RaisedButton(
              child: Text("Get Directions"),
              onPressed: () {
                drawRoute();
              },
            ),
            Container(
              height: height / 3,
              width: width,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                myLocationButtonEnabled: false,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                polylines: Set<Polyline>.of(polylines.values),
                markers: Set<Marker>.of(markers.values),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  clearMap() {
    polylines.clear();
    markers.clear();
    CameraUpdate update = CameraUpdate.newCameraPosition(initialLocation);
    mapController.moveCamera(update);
    setState(() {});
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 4,
      color: Colors.lightBlue,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(points) {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(points);
    result.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    _addPolyLine(polylineCoordinates);
  }

  drawRoute() {
    clearMap();
    ServerFacade.getDirectionsBetweenTwoCities("Highland, UT", "Austin, TX")
        .then((response) {
      var distance = response["routes"][0]["legs"][0]["distance"]["text"];
      var duration = response["routes"][0]["legs"][0]["duration"]["text"];
      var startLocation = response["routes"][0]["legs"][0]["start_location"];
      var endLocation = response["routes"][0]["legs"][0]["end_location"];
      var points = response["routes"][0]["overview_polyline"]["points"];
      var bounds = response["routes"][0]["bounds"];
      print("Distance: " + distance.toString());
      print("Duration: " + duration.toString());
      print("Start: " + startLocation.toString());
      print("End: " + endLocation.toString());
      print("Points: " + points.toString());

      _addMarker(
        LatLng(startLocation["lat"], startLocation["lng"]),
        "origin",
        BitmapDescriptor.defaultMarker,
      );

      _addMarker(
        LatLng(endLocation["lat"], endLocation["lng"]),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90),
      );

      _getPolyline(points);

      var sw = LatLng(bounds["southwest"]["lat"], bounds["southwest"]["lng"]);
      var ne = LatLng(bounds["northeast"]["lat"], bounds["northeast"]["lng"]);
      LatLngBounds bound = LatLngBounds(southwest: sw, northeast: ne);
      CameraUpdate update = CameraUpdate.newLatLngBounds(bound, 50);

      // var cameraLat = (startLocation["lat"] + endLocation["lat"]) / 2;
      // var cameraLng = (startLocation["lng"] + endLocation["lng"]) / 2;
      // var newPosition =
      //     CameraPosition(target: LatLng(cameraLat, cameraLng), zoom: 6);
      //CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
      mapController.moveCamera(update);
    });
  }
}
