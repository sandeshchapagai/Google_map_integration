import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Marker> _marker = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.237988, 83.995590),
    )
  ];

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(28.237988, 83.995590),
    zoom: 10,
  );

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGoogle,
        markers: Set<Marker>.of(_marker),
        // mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
