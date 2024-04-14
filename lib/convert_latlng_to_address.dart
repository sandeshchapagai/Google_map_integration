import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertingLatlang extends StatefulWidget {
  const ConvertingLatlang({super.key});

  @override
  State<ConvertingLatlang> createState() => _ConvertingLatlangState();
}

class _ConvertingLatlangState extends State<ConvertingLatlang> {
  String stAddress = '';

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
                // List<Location> location = await locationFromAddress("Gronausestraat 710, Enschede");

                List<Placemark> location =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);
                setState(() {
// stAddress=location.last.longitude.toString()+"  "+location.last.longitude.toString();
                  stAddress = location.last.country.toString() +
                      "  " +
                      location.last.country.toString();
                });
              },
              child: Container(
                height: 60,
                color: Colors.green,
                child:Center(
                  child: Text('convert'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
