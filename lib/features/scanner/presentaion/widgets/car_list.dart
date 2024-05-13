import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:parking_client/features/cars/data/models/car.dart';
import 'package:parking_client/features/cars/providers/states/car_state.dart';

class CarList extends StatefulWidget {
  final CarState carState; // List of cars to display in the dropdown
  final Function(Car?)? onSelected; // Callback to notify the parent

  const CarList({
    super.key,
    required this.carState,
    this.onSelected,
  });

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  Car? selectedCar; // The selected car object

  @override
  Widget build(BuildContext context) {
    if (widget.carState is CarInitial) {
      return const CircularProgressIndicator();
    } else if (widget.carState is CarLoading) {
      return const CircularProgressIndicator();


    } else if (widget.carState is CarSuccess) {
      return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          'Sélectionner votre voiture',
          style: TextStyle(
            color: Colors.white, // Change the hint text color
          ),
        ),
        items: (widget.carState as CarSuccess).cars.map((car) {
          return DropdownMenuItem<Car>(

            value: car, // Use the Car object as the value
            child: Text(
              car.model,
              style: const TextStyle(
                color: Colors.white, // Change the hint text color
              ),
            ), // Display the car model
          );
        }).toList(),
        value: selectedCar, // The currently selected car
        onChanged: (value) {
          setState(() {
            selectedCar = value; // Update the selected car
          });
          if (widget.onSelected != null) {
            widget.onSelected!(selectedCar); // Notify the parent widget
          }
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
      





    } else if (widget.carState is CarFailure) {
      return Text(widget.carState.props[0].toString());
    } else {
      return const CircularProgressIndicator();
    }

  }
}
