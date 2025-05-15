import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';
import 'package:siram_pintar_mobile/utils/mqtt_service.dart';
import 'dart:convert';

class SensorDeviceWidget extends StatefulWidget {
  final DeviceData deviceData;
  final VoidCallback? onTap;

  const SensorDeviceWidget({
    super.key,
    required this.deviceData,
    this.onTap,
  });

  @override
  State<SensorDeviceWidget> createState() => _SensorDeviceWidgetState();
}

class _SensorDeviceWidgetState extends State<SensorDeviceWidget> {
  late MqttService mqttService;
  String sensorValue = '-';

  @override
  void initState() {
    super.initState();
    mqttService = MqttService();

    mqttService.connect().then((_) {
      mqttService.subscribe(widget.deviceData.deviceType);
    });

    mqttService.setOnMessageReceived((String topic, String payload) {
      try {
        final data = jsonDecode(payload);
        if (data['device_key'] == widget.deviceData.deviceKey) {
          setState(() {
            sensorValue = data['value'].toString();
          });
        }
      } catch (e) {
        print('Failed to decode MQTT message: $e');
      }
    });
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 8),
                    Text(widget.deviceData.deviceName),
                    Text(sensorValue),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Icon(Icons.edit, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
