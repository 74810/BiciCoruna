import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodels/station_viewmodel.dart';
import '../models/station.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StationViewModel>(context, listen: false).loadStationsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StationViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('BiciCoruña'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 79, 165, 245),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (vm.stations.isEmpty && vm.isLoading)
              LinearProgressIndicator()
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<StationInfo>(
                    isExpanded: true,
                    hint: Text("Selección de estación..."),
                    value: vm.selectedStation,
                    items: vm.stations.map((StationInfo station) {
                      return DropdownMenuItem<StationInfo>(
                        value: station,
                        child: Text(station.name, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (StationInfo? newValue) {
                      if (newValue != null) {
                        vm.selectStation(newValue);
                      }
                    },
                  ),
                ),
              ),

            SizedBox(height: 20),

            if (vm.isLoading && vm.selectedStation != null)
              Expanded(child: Center(child: CircularProgressIndicator()))
            else if (vm.errorMessage.isNotEmpty)
              Expanded(child: Center(child: Text(vm.errorMessage, style: TextStyle(color: Colors.red))))
            else if (vm.stationStatus != null)
              _buildStationDetail(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildStationDetail(StationViewModel vm) {
    final status = vm.stationStatus!;
    final date = DateTime.fromMillisecondsSinceEpoch(status.lastReported * 1000);
    final formattedTime = DateFormat('HH:mm').format(date);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Expanded(
            flex: 4, 
            child: Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pedal_bike, size: 50, color: Colors.green),
                  Text(
                    "${status.numBikesAvailable}",
                    style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    "Bicicletas\nDisponibles", 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[800], fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
          ),        

          SizedBox(height: 10),

          Expanded(
            flex: 2,
            child: Card(
              color: Color.fromARGB(255, 174, 247, 177),
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("${status.numDocksAvailable}", 
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87)
                    ),
                   SizedBox(width: 15),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Aparcamientos", style: TextStyle(fontSize: 16)),
                      Text("Libres", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${status.totalCapacity}", 
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                        Text("Capacidad\nde la estación", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.red[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${status.numDocksDisabled}", 
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                        Text("Bicicletas\nAveriadas", style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Actualizado a las $formattedTime",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}