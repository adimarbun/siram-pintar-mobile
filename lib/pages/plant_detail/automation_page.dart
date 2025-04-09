import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/automation_schedule_page.dart';

class AutomationListPage extends StatelessWidget {
  const AutomationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = ['Pompa 1 penyiraman', 'Pompa 2', 'Pompa 3'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Automasi'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: List.generate(names.length, (index) {
              final name = names[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AutomationSchedulePage(deviceName: name),
                        ),
                      );
                    },
                  ),
                  if (index != names.length - 1)
                    const Divider(height: 1, thickness: 1),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
