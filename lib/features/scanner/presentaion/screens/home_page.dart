import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/providers/car_controller.dart';
import 'package:parking_client/features/cars/providers/states/car_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _getCars();
    });
  }

  Future<void> _getCars() async {
    final carController = ref.read(carControllerProvider.notifier);
    try {
      await carController.getCarDetail(['1', '2', '3']);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    var carsState = ref.watch(carControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('select you car'),
            carList(carsState),
          ],
        ),
      ),
    );
  }

  Widget carList(CarState carsState){
    if (carsState is CarInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (carsState is CarLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (carsState is CarSuccess) {
      return Expanded(
        child: ListView.builder(
          itemCount: carsState.cars.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(carsState.cars[index].model),
              subtitle: Text(carsState.cars[index].licenseNumber),
            );
          },
        ),
      );
    } else if (carsState is CarFailure) {
      return Center(
        child: Text(carsState.error),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
      
    }
  }
}