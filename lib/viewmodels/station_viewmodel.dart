import 'package:flutter/material.dart';
import '../models/station.dart';
import '../services/api_service.dart';

class StationViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<StationInfo> _stations = [];
  List<StationInfo> get stations => _stations;

  StationInfo? _selectedStation;
  StationInfo? get selectedStation => _selectedStation;

  StationStatus? _stationStatus;
  StationStatus? get stationStatus => _stationStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadStationsList() async {
    _setLoading(true);
    try {
      _stations = await _apiService.fetchStationsInfo();
      _stations.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      _errorMessage = 'No se pudo cargar la lista de estaciones.';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> selectStation(StationInfo station) async {
    _selectedStation = station;
    _stationStatus = null; 
    notifyListeners();
    
    await loadStationDetails(station.id);
  }

  Future<void> loadStationDetails(String id) async {
    _setLoading(true);
    try {
      _stationStatus = await _apiService.fetchStationStatus(id);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Error obteniendo datos en tiempo real.';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}