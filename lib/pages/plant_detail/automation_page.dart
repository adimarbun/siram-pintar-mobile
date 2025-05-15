import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/automation_schedule_page.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_cubit.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_state.dart';



class AutomationListPage extends StatefulWidget {
  final int plantId;

  const AutomationListPage({super.key, required this.plantId});

  @override
  State<AutomationListPage> createState() => _AutomationListPageState();
}

class _AutomationListPageState extends State<AutomationListPage> {
  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  void _getDevices() {
    context.read<DevicesPlantCubit>().getDevices(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automasi'),
        leading: BackButton(),
      ),
      body: BlocBuilder<DevicesPlantCubit, DevicesPlantState>(
        builder: (context, state) {
          if (state is DevicesPlantSLoaded) {
            final pompaDevices = state.devicesPlantResponseModel.data
                .where((device) => device.deviceType == 'Pompa')
                .toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: List.generate(pompaDevices.length, (index) {
                    final device = pompaDevices[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(device.deviceName ?? 'Pompa ${index + 1}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AutomationSchedulePage(
                                  deviceName: device.deviceName ?? 'Pompa',
                                  deviceId: device.id,
                                  plantId: device.plantId,
                                ),
                              ),
                            );
                          },
                        ),
                        if (index != pompaDevices.length - 1)
                          const Divider(height: 1, thickness: 1),
                      ],
                    );
                  }),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
