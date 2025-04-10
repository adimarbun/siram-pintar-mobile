import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:siram_pintar_mobile/models/sensor_data_model.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';
import 'package:siram_pintar_mobile/repositories/device_repository.dart';

class SensorHistoryPage extends StatefulWidget {
  final DeviceData sensorDeviceData;

  const SensorHistoryPage({super.key, required this.sensorDeviceData});

  @override
  State<SensorHistoryPage> createState() => _SensorHistoryPageState();
}

class _SensorHistoryPageState extends State<SensorHistoryPage> {
  String selectedFilter = '1 Hari';
  List<SensorDataModel> sensorData = [];
  bool isLoading = false;

  final DeviceRepository deviceRepository = DeviceRepository();

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  String _filterQueryParam(String label) {
    switch (label) {
      case '1 Hari':
        return '1d';
      case '1 Minggu':
        return '7d';
      case '1 Bulan':
        return '1m';
      case '1 Tahun':
        return '1y';
      default:
        return '1d';
    }
  }

  void _loadSensorData() async {
    final deviceId = widget.sensorDeviceData.id.toString();

    setState(() {
      isLoading = true;
    });

    try {
      final result = await deviceRepository.fetchSensorHistory(
        deviceId: deviceId,
        filter: _filterQueryParam(selectedFilter),
      );

      setState(() {
        sensorData = result;
        isLoading = false;
      });
    } catch (e) {
      print('Gagal ambil data sensor: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<FlSpot> _generateSpots() {
    return sensorData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value.toDouble());
    }).toList();
  }

  List<String> _generateTimeLabels() {
    return sensorData.map((e) {
      return DateFormat.Hm().format(e.timestamp.toLocal()); // HH:mm format
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();
    final timeLabels = _generateTimeLabels();

    return Scaffold(
      appBar: AppBar(title: Text(widget.sensorDeviceData.deviceName)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              items: ['1 Hari', '1 Minggu', '1 Bulan', '1 Tahun']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                  _loadSensorData();
                });
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : sensorData.isEmpty
                    ? const Center(child: Text('Tidak ada data sensor'))
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index < 0 || index >= timeLabels.length) return const SizedBox.shrink();
                                    return Text(
                                      timeLabels[index],
                                      style: const TextStyle(fontSize: 10),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 10,
                                  getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                                ),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                dotData: FlDotData(show: false),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
