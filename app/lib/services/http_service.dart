import 'dart:convert';
import 'package:http/http.dart' as http;


class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> torneos() async {
    try {
      var url = Uri.parse('$apiUrl/torneos');

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        print("Se obtiene respuesta de la api");
        return json.decode(respuesta.body)['data'];
      } else {
        print('Failed to load data: ${respuesta.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<dynamic>> equipos() async {
    try {
      var url = Uri.parse('$apiUrl/equipos');

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        print("Se obtiene respuesta de la api");
        return json.decode(respuesta.body)['data'];
      } else {
        print('Failed to load data: ${respuesta.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<dynamic>> partidos({String? orden}) async {
    try {
      var url = Uri.parse('$apiUrl/partidos?orden=$orden');

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        print("Se obtiene respuesta de la api");
        return json.decode(respuesta.body)['data'];
      } else {
        print('Failed to load data: ${respuesta.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> equipo({int? $id}) async {
    try {
      var url = Uri.parse('$apiUrl/equipos/'+$id.toString());

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
          print("Se obtiene respuesta de la api");
          return json.decode(respuesta.body)['data'];
        } else {
          print('Failed to load data: ${respuesta.statusCode}');
          return {};
        }
      } catch (e) {
        print('Error occurred: $e');
        return {};
      }
  }
  Future<Map<String, dynamic>> torneo({int? $id}) async {
    try {
      var url = Uri.parse('$apiUrl/torneos/'+$id.toString());

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
          print("Se obtiene respuesta de la api");
          return json.decode(respuesta.body)['data'];
        } else {
          print('Failed to load data: ${respuesta.statusCode}');
          return {};
        }
      } catch (e) {
        print('Error occurred: $e');
        return {};
      }
  }
  Future<Map<String, dynamic>> partido({int? $id}) async{
    try {
      var url = Uri.parse('$apiUrl/partidos/'+$id.toString());

      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return json.decode(respuesta.body)['data'];
      }else{
        return {};
      }
    } catch (e){
      return {};
    }
  }

  Future<http.Response> agregarTorneo(Map<String, dynamic> data) async {
    var url = Uri.parse('$apiUrl/torneos');
    return await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
  }
  Future<http.Response> agregarEquipo(Map<String, dynamic> data) async {
    var url = Uri.parse('$apiUrl/equipos');
    return await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
  }
  Future<http.Response> crearPartido(int equipo1Id, int equipo2Id, DateTime fecha, int? puntosEquipo1, int? puntosEquipo2, int torneoId, bool completado) async {
    var url = Uri.parse('$apiUrl/partidos');
    Map<String, dynamic> data = {
      'equipo1_id': equipo1Id,
      'equipo2_id': equipo2Id,
      'fecha': fecha.toIso8601String(), // Convertir a ISO 8601 string
      'equipo1_puntos': puntosEquipo1 ?? 0,
      'equipo2_puntos': puntosEquipo2 ?? 0,
      'fk_torneo_id': torneoId,
      'completado': completado, // Asumir que el backend espera un entero
    };
    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if(response.statusCode == 201){
      return response;
    }else{
      throw Exception('Error al crear el partido: ${response.body}');
    }
  }
  Future<http.Response> agregarJugador(Map<String, dynamic> data) async {
    var url = Uri.parse('$apiUrl/jugadores');
    return await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
  }
  Future<void> eliminarJugador(int id) async {
    var url = Uri.parse('$apiUrl/jugadores/$id');
    var response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el jugador: ${response.body}');
    }
  }

  Future<void> eliminarEquipo(int id) async {
    var url = Uri.parse('$apiUrl/equipos/$id');
    var response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el equipo: ${response.body}');
    }
  }

  Future<void> eliminarTorneo(int torneoId) async {
  var partidosUrl = Uri.parse('$apiUrl/partidos/torneos/$torneoId');
  var partidosResponse = await http.get(partidosUrl);

  if (partidosResponse.statusCode != 200) {
    throw Exception('Error al obtener los partidos del torneo: ${partidosResponse.body}');
  }

  var partidos = json.decode(partidosResponse.body);
  print(partidos);

  var partidosList = partidos as List<dynamic>;
  print(partidosList);

  // Eliminar cada partido vinculado al torneo
  for (var partido in partidosList) {
    var partidoId = partido['id'];
    var partidoUrl = Uri.parse('$apiUrl/partidos/$partidoId');
    var partidoResponse = await http.delete(partidoUrl);
    print(partidoResponse);

    if (partidoResponse.statusCode != 204) {
      throw Exception('Error al eliminar el partido: ${partidoResponse.body}');
    }
  }

  var url = Uri.parse('$apiUrl/torneos/$torneoId');
  var response = await http.delete(url);

  if (response.statusCode != 204) {
    throw Exception('Error al eliminar el torneo: ${response.body}');
  }
}

  Future<void> eliminarPartido(int id) async {
    var url = Uri.parse('$apiUrl/partidos/$id');
    var response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el partido: ${response.body}');
    }
  }
}