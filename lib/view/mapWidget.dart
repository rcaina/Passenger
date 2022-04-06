import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/network/server_facade.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(this.trip);
  final dynamic trip;
  @override
  _MapWidgetState createState() => _MapWidgetState(this.trip);
}

// Markers to show points on the map
Map<MarkerId, Marker> markers = {};
List<PointLatLng> polylinePoints = [];
Map<PolylineId, Polyline> polylines = {};

class _MapWidgetState extends State<MapWidget> {
  _MapWidgetState(this.trip);
  dynamic trip;

  PolylinePoints polylinePoints = PolylinePoints();
  late GoogleMapController mapController;
  CameraPosition initialLocation = CameraPosition(
    target: LatLng(40, -100),
    zoom: 3.5,
  );

  @override
  void initState() {
    super.initState();
    if (trip["startLocation"].toString().isNotEmpty &&
        trip["destination"].toString().isNotEmpty) {
      drawRoute(trip["startLocation"], trip["destination"],
          getWaypoints(trip["passengers"]));
    } else {
      clearMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initial location of the Map view

    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 220,
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
    );
  }

  clearMap() {
    polylines.clear();
    markers.clear();
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

  getWaypoints(passengers) {
    String waypoints = "";
    for (dynamic passenger in passengers) {
      if (passenger["status"] == "confirmed") {
        waypoints += passenger["destination"] + "|";
      }
    }
    return waypoints;
  }

  drawRoute(start, destination, waypoints) {
    clearMap();

    ServerFacade.getDirections(start, destination, waypoints).then((route) {
      //var distance = response["routes"][0]["legs"][0]["distance"]["text"];
      //var duration = response["routes"][0]["legs"][0]["duration"]["text"];

      for (var i = 0; i < route["legs"].length; i++) {
        var startAddress = route["legs"][i]["start_address"];
        var endAddress = route["legs"][i]["end_address"];
        var startLocation = route["legs"][i]["start_location"];
        var endLocation = route["legs"][i]["end_location"];

        _addMarker(
          LatLng(startLocation["lat"], startLocation["lng"]),
          startAddress,
          BitmapDescriptor.defaultMarker,
        );
        _addMarker(
          LatLng(endLocation["lat"], endLocation["lng"]),
          endAddress,
          BitmapDescriptor.defaultMarker,
        );
      }
      var startAddress = route["legs"][0]["start_address"];
      var startLocation = route["legs"][0]["start_location"];
      _addMarker(
        LatLng(startLocation["lat"], startLocation["lng"]),
        startAddress,
        BitmapDescriptor.defaultMarkerWithHue(90),
      );

      var points = route["overview_polyline"]["points"];
      var bounds = route["bounds"];

      _getPolyline(points);

      var sw = LatLng(bounds["southwest"]["lat"], bounds["southwest"]["lng"]);
      var ne = LatLng(bounds["northeast"]["lat"], bounds["northeast"]["lng"]);
      LatLngBounds bound = LatLngBounds(southwest: sw, northeast: ne);
      CameraUpdate update = CameraUpdate.newLatLngBounds(bound, 40);
      mapController.moveCamera(update);
    });
  }
}
