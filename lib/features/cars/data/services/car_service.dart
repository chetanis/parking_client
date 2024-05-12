

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/data/models/car.dart';

class CarService {

    Future<List<Car>?> getCar(List<String> carIds) async {
        var car1 = const Car(id: '1',model: 'rs 3',licenseNumber: '123456.123.12',serialNumber: 'ASDFGHJ');
        var car2 = const Car(id: '2',model: 'micra',licenseNumber: '123456.123.12',serialNumber: 'QWERTY');
        var car3 = const Car(id: '3',model: 'tigwan',licenseNumber: '123456.123.12',serialNumber: 'ZXCVBNM');

        // Simulate a network request
        await Future.delayed(const Duration(seconds: 1));

        return [car1, car2, car3];
    }

}

final carServiceProvider = Provider<CarService>((ref) => CarService());