import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/plants/plants_cubit.dart';
import 'package:siram_pintar_mobile/cubits/plants/plants_state.dart';
import 'package:siram_pintar_mobile/models/plant_detail_page_parameter_model.dart';
import 'package:siram_pintar_mobile/pages/add_plant/add_plant_page.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/plant_detail_page.dart';
import 'package:siram_pintar_mobile/utils/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getPlants();
    super.initState();
  }

  void _getPlants() => context.read<PlantsCubit>().getPlants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanaman'),
        centerTitle: true,
      ),
      body: BlocBuilder<PlantsCubit, PlantsState>(
        builder: (context, plantState) {
          if (plantState is PlantsLoaded) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            Navigation.push(context, const AddPlantPage()),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Tambah'),
                      ),
                      const SizedBox(height: 16.0),
                      if (plantState.plantResponse.data.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              plantState.plantResponse.data.length,
                              (index) {
                                final plant =
                                    plantState.plantResponse.data[index];
                                return ListTile(
                                  title: Text(
                                    plant.plantName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    '5 Collections',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () =>  Navigation.push(context, PlantDetailPage(params: PlantDetailPageParameterModel(plantData: plant,))),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
