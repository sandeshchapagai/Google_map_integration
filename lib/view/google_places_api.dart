import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  Future<void> getSuggestion(String input) async {
    String Places_API_KEY = 'AIzaSyBR2ertnTApvVuqFk2ssrdNr3F0u8rQSc4';
    String baseURl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURl?input=$input&key=$Places_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['prediction'];
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Search Places Api',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Search places'),
            )
          ],
        ),
      ),
    );
  }
}
