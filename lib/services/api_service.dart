import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/station.dart';

class ApiService {
  final String _infoUrl = 'https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl/station_information';
  final String _statusUrl = 'https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl/station_status';

  Future<List<StationInfo>> fetchStationsInfo() async {
    final response = await http.get(Uri.parse(_infoUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List stationsJson = data['data']['stations'];
      return stationsJson.map((json) => StationInfo.fromJson(json)).toList();
    } else {
      throw Exception('Error cargando lista de estaciones');
    }
  }

  Future<StationStatus> fetchStationStatus(String stationId) async {
    final response = await http.get(Uri.parse(_statusUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List stationsJson = data['data']['stations'];
      
      final stationJson = stationsJson.firstWhere((s) => s['station_id'] == stationId);
      return StationStatus.fromJson(stationJson);
    } else {
      throw Exception('Error cargando estado de la estación');
    }
  }
}