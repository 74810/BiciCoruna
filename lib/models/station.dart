class StationInfo {
  final String id;
  final String name;

  StationInfo({required this.id, required this.name});

  factory StationInfo.fromJson(Map<String, dynamic> json) {
    return StationInfo(
      id: json['station_id'],
      name: json['name'],
    );
  }
}

class StationStatus {
  final String id;
  final int numBikesAvailable;
  final int numDocksAvailable;
  final int numDocksDisabled;
  final int lastReported; 

  int get totalCapacity => numBikesAvailable + numDocksAvailable + numDocksDisabled;

  StationStatus({
    required this.id,
    required this.numBikesAvailable,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.lastReported,
  });

  factory StationStatus.fromJson(Map<String, dynamic> json) {
    return StationStatus(
      id: json['station_id'],
      numBikesAvailable: json['num_bikes_available'],
      numDocksAvailable: json['num_docks_available'],
      numDocksDisabled: json['num_docks_disable'] ?? 0,
      lastReported: json['last_reported'],
    );
  }
}