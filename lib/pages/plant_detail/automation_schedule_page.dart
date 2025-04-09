import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/add_schedule_page.dart';

class AutomationSchedulePage extends StatelessWidget {
  final String deviceName;

  const AutomationSchedulePage({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> schedules = [
      {'time': 'Jam 12:00', 'duration': '20 detik'},
      {'time': 'Jam 14:00', 'duration': '30 detik'},
      {'time': 'Jam 19:00', 'duration': '10 detik'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(deviceName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddSchedulePage(), 
                      ),
                    );
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text('Tambah Jadwal'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                  itemCount: schedules.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = schedules[index];
                    return ListTile(
                      title: Text(item['time'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item['duration']),
                      leading: const SizedBox(width: 1),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
