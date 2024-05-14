import 'package:flutter/material.dart';
import 'package:parking_client/features/cars/data/models/car.dart';
import 'package:parking_client/features/profile/presenetation/widget/car_item.dart';

class MyCarsSection extends StatelessWidget {
  final List<Car> cars;
  const MyCarsSection({super.key,required this.cars}); // Example cars

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text("My Cars"),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to "Add Car" page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AddCarPage()),
                // );
              },
            ),
          ),
          ...cars.map((car) => CarItem(car: car, context: context)),
        ],
      ),
    );
  }
}