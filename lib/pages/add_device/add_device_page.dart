import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/add_device_plant/add_device_plant_cubit.dart';
import 'package:siram_pintar_mobile/cubits/add_device_plant/add_device_plant_state.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_cubit.dart';
import 'package:siram_pintar_mobile/models/add_device_page_parameter_model.dart';
import 'package:siram_pintar_mobile/utils/form_validator.dart';

class AddDevicePage extends StatefulWidget {
  final AddDevicePageParameterModel params;

  const AddDevicePage({
    super.key,
    required this.params,
  });

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final List<String> _controllerTypes = ['Pompa', 'Sensor'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<AddDevicePlantCubit>().onSave(
        widget.params.plantData.id,
        onLoading: () {},
        onFailed: (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$err')),
          );
        },
        onSuccess: () {
          Navigator.pop(context);
          context.read<DevicesPlantCubit>().getDevices( widget.params.plantData.id);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Perangkat',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Nama:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama perangkat',
                ),
                validator: emptyValidator,
                onChanged: context.read<AddDevicePlantCubit>().onChangeName,
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Controller Type:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              BlocBuilder<AddDevicePlantCubit, AddDevicePlantState>(
                  builder: (context, addPlantState) {
                return DropdownButtonFormField<String>(
                  value: addPlantState.ctrlTypeTextField,
                  items: _controllerTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged:
                      context.read<AddDevicePlantCubit>().onChangeCtrlType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                );
              }),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
