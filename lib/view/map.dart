import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/globals.dart' as globals;

import 'dart:async';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

// Starting point latitude
double _originLatitude = 6.5212402;
// Starting point longitude
double _originLongitude = 3.3679965;
// Destination latitude
double _destLatitude = 6.849660;
// Destination Longitude
double _destLongitude = 3.648190;
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

//PolylinePoints polylinePoints = PolylinePoints();
List<PointLatLng> polylinePoints = [];

Map<PolylineId, Polyline> polylines = {};

class _MapViewState extends State<MapView> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  // Configure map position and zoom
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 1.4746,
  );

  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    /// add origin marker origin marker
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initial location of the Map view
    CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

    // For controlling the view of the Map
    late GoogleMapController mapController;

    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          polylines: Set<Polyline>.of(polylines.values),
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

// This method will add markers to the map based on the LatLng position
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
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(
        "kn}tFnkvhTm@R?yBCeDGK?iA@uEDwPB{DH{XF_SHuULaW?yFUiUG{DFUCsBIuGE}AOSWmBg@oDS_BAo@AwA?YAsIGkRB_BzDj@nOpBjC^nFp@rDTnJd@pBD|CRrFThFJ~CCfACtAKvBMdFc@|UqBpCS`EUnQaAjQaAhBGvA?lBJpAJtAT~Dv@xKtBlIzAfAJx@DbB@pB?hH@lT?xG?~K@|G?tE@~@BpDEjMBnIBlQ?fN@xC@fD@H?LN^@zGDvAAfE@fB?pA??i@@gF@kBvCAnB??pDAxC");
    print(result);

    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyB-xwiFx0RmrOWmoDjsXHb4cGYbsL4128U",
    //   PointLatLng(_originLatitude, _originLongitude),
    //   PointLatLng(_destLatitude, _destLongitude),
    //   travelMode: TravelMode.driving,
    // );
    result.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    _addPolyLine(polylineCoordinates);
  }
}
