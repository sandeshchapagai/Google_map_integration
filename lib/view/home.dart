import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Marker> _marker = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(28.2774, 83.5816),
        infoWindow: InfoWindow(title: 'ajksd')),
    Marker(markerId: MarkerId('3'), position: LatLng(28.263610, 83.972390)),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(28.237988, 83.995590),
        infoWindow: InfoWindow(title: 'current location'))
  ];
  Future<Position>  getUserCurrentLocation()  async{
await Geolocator.requestPermission().then((value){

}).onError((error, stackTrace){
  print('error');
});
return await Geolocator.getCurrentPosition();
  }
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(28.237988, 83.995590),
    zoom: 10,
  );

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () async {


          getUserCurrentLocation().then((value) async {print('my current location');
          print(value.latitude.toString()+""+value.longitude.toString());
          _marker.add(Marker(markerId: MarkerId('3'),
          position: LatLng(value.latitude,value.longitude),
            infoWindow: InfoWindow(
              title: "my location"
            )
          ));


          CameraPosition cameraPosition=CameraPosition(target: LatLng(value.latitude,value.longitude));
          final GoogleMapController controller = await _controller.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {

          });
          });
          // GoogleMapController controller = await _controller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //       CameraPosition(target: LatLng(28.263610, 83.972390), zoom: 100)),
          // );
        },
      ),
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
