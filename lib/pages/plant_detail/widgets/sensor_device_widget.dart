import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';

class SensorDeviceWidget extends StatelessWidget {
  final DeviceData deviceData;

  const SensorDeviceWidget({
    super.key,
    required this.deviceData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(deviceData.deviceName),
                  const Text('40'),
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
    );
  }
}
