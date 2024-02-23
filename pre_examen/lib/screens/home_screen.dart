import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pre_examen/screens/mapa_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> fetchPostCode() async {
    final response = await http.get(Uri.parse('https://api.zippopotam.us/es/${_controller.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final places = data['places'];
      if (places.length > 0) {
        final place = places[0];
        final location = LatLng(double.parse(place['latitude']), double.parse(place['longitude']));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapaScreen(location: location)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Codi Postal',
              ),
            ),
            ElevatedButton(
              onPressed: fetchPostCode,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}