import 'package:flutter/material.dart';
import 'package:parking_client/features/cars/data/models/car.dart';

class CarItem extends StatelessWidget {
  final Car car;
  final BuildContext context;

  const CarItem({super.key, required this.car, required this.context});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(car.model),
      subtitle: Text("matricule: ${car.licenseNumber}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to "Edit Car" page
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Handle car removal
            },
          ),
        ],
      ),
    );
  }
}