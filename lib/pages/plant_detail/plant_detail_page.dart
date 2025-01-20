import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_cubit.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_state.dart';
import 'package:siram_pintar_mobile/models/add_device_page_parameter_model.dart';
import 'package:siram_pintar_mobile/models/plant_detail_page_parameter_model.dart';
import 'package:siram_pintar_mobile/pages/add_device/add_device_page.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/widgets/pump_device_widget.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/widgets/sensor_device_widget.dart';
import 'package:siram_pintar_mobile/utils/navigation.dart';

class PlantDetailPage extends StatefulWidget {
  final PlantDetailPageParameterModel params;

  const PlantDetailPage({
    super.key,
    required this.params,
  });

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  @override
  void initState() {
    _getDevice();
    super.initState();
  }

  void _getDevice() =>
      context.read<DevicesPlantCubit>().getDevices(widget.params.plantData.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.plantData.plantName),
      ),
      body: BlocBuilder<DevicesPlantCubit, DevicesPlantState>(
          builder: (context, devicesState) {
        if (devicesState is DevicesPlantSLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigation.push(
                            context,
                            AddDevicePage(
                              params: AddDevicePageParameterModel(
                                plantData: widget.params.plantData,
                              ),
                            ),
                          );
                        },
                        child: const Text('Tambah Perangkat'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final data
                            in devicesState.devicesPlantResponseModel.data)
                          if (data.deviceType == 'Pompa')
                            PumpDeviceWidget(
                              deviceData: data,
                            ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        for (final data
                            in devicesState.devicesPlantResponseModel.data)
                          if (data.deviceType == 'Sensor')
                            SensorDeviceWidget(
                              deviceData: data,
                            ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Automasi'),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
