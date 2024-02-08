import 'dart:convert';
import 'package:http/http.dart' as http;

class MenuProvider {
  List<dynamic> opciones = [];

  MenuProvider() {
    cargarData();
  }

Future<List<dynamic>> cargarData() async {
    final url = Uri.parse('https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app/users.json');
    final resp = await http.get(url);
    Map dataMap = json.decode(resp.body);
    opciones = dataMap.values.toList();
    return opciones;
  }
}