import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';
import 'package:siram_pintar_mobile/utils/mqtt_service.dart'; 

class PumpDeviceWidget extends StatefulWidget {
  final DeviceData deviceData;

  const PumpDeviceWidget({
    super.key,
    required this.deviceData,
  });

  @override
  State<PumpDeviceWidget> createState() => _PumpDeviceWidgetState();
}

class _PumpDeviceWidgetState extends State<PumpDeviceWidget> {
  bool _isActive = false;
  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    mqttService = MqttService();
    mqttService.connect(); // Koneksi ke MQTT saat widget dibuat
  }

  void _togglePump() {
    setState(() {
      _isActive = !_isActive;
    });

    // Publish ke MQTT
    String topic = 'home/garden/sensor';
    String message = _isActive ? 'ON' : 'OFF';
    mqttService.publish(topic, message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: _togglePump, // Panggil fungsi saat tombol ditekan
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _isActive ? Colors.amber : Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_isActive ? 'nyala' : 'mati'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.deviceData.deviceName),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: const Icon(Icons.edit, size: 28),
          ),
        ],
      ),
    );
  }
}
