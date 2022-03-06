import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:persistent_state/app/ui/pages/city_picker/controller/city_picker_controller.dart';
import 'controller/city_picker_provider.dart';

class CityPickerPage extends StatelessWidget {
  const CityPickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<CityPickerController>(
      provider: cityPickerProvider,
      onAfterFirstLayout: (_, controller) => controller.load(),
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Consumer(
              builder: (_, ref, __) {
                final state = ref.watch(cityPickerProvider).state;
                return state.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (cities) => ListView.builder(
                    itemBuilder: (_, index) => ListTile(
                      title: Text(cities[index].name),
                      subtitle: Text(cities[index].state),
                    ),
                    itemCount: cities.length,
                  ),
                  error: () => const Center(
                    child: Text("Error"),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
