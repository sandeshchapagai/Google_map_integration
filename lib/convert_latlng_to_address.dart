import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
class ConvertingLatlang extends StatefulWidget {
  const ConvertingLatlang({super.key});

  @override
  State<ConvertingLatlang> createState() => _ConvertingLatlangState();
}

class _ConvertingLatlangState extends State<ConvertingLatlang> {
  String stAddress='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Google  Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: GestureDetector(
    onTap: () async {
      final query ="1600 Amphiteatre parkway ,Mountain View";
      var address1 = await Geocoder.local.findAddressesFromQuery(query);
      var second = address1.first;
      print("${second.featureName}:${second.coordinates}");


      final coordinates = new Coordinates(33.6992, 72.9744);
      var address =await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = address.first;
      print(first.featureName! + first.addressLine.toString());

      setState(() {
stAddress=first.adminArea.toString();
      });
    },
    child: Container(height: 60,
    color: Colors.green,
    child: Center(
      child: Text('convert'),
    ),),
  ),
)
        ],
      ),
    );
  }
}
