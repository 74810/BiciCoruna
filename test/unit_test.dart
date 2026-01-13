import 'package:flutter_test/flutter_test.dart';
import 'package:bicicoruna/models/station.dart';
import 'package:bicicoruna/viewmodels/station_viewmodel.dart';

void main() {
  group('Grupo 1: Tests de Lógica de Negocio (Modelos)', () {
    test('StationStatus calcula correctamente la capacidad total', () {
      final status = StationStatus(
        id: '1', numBikesAvailable: 5, numDocksAvailable: 10,
        numDocksDisabled: 2, lastReported: 1234567890,
      );
      expect(status.totalCapacity, 17);
    });

    test('StationInfo.fromJson crea el objeto correctamente', () {
      final json = {'station_id': '10', 'name': 'Torre de Hércules'};
      final station = StationInfo.fromJson(json);
      expect(station.id, '10');
      expect(station.name, 'Torre de Hércules');
    });
  });

  group('Grupo 2: Estado Inicial del ViewModel', () {
    test('El ViewModel debe iniciar con valores vacíos', () {
      final vm = StationViewModel();
      expect(vm.stations, isEmpty);
      expect(vm.isLoading, false);
      expect(vm.selectedStation, isNull);
    });
  });

  group('Grupo 3: Selección de Estación', () {
    test('selectStation actualiza la estación seleccionada', () {
      final vm = StationViewModel();
      final station = StationInfo(id: '1', name: 'Obelisco');
      
      vm.selectStation(station);
      
      expect(vm.selectedStation, isNotNull);
      expect(vm.selectedStation!.name, 'Obelisco');
    });
  });
}