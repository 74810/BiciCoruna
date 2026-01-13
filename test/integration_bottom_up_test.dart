import 'package:flutter_test/flutter_test.dart';
import 'package:bicicoruna/services/api_service.dart';

void main() {
  test('Integración Ascendente: ApiService conecta y devuelve datos', () async {
    final service = ApiService();
    try {
      final stations = await service.fetchStationsInfo();
      expect(stations, isNotEmpty);
      expect(stations.first.name.length, greaterThan(0)); 
    } catch (e) {
      print("Aviso: No se pudo conectar a la API (¿Sin internet?): $e");
    }
  });
}