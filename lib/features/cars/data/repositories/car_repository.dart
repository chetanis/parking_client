
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/data/models/car.dart';
import 'package:parking_client/features/cars/data/services/car_service.dart';

class CarRepository {
  final CarService _carService;

  CarRepository(this._carService);

  Future<List<Car>?> getCarDetail(List<String> carIds) async{
    return _carService.getCar(carIds);
  }

}

final carRepositoryProvider = Provider<CarRepository>((ref) {
  return CarRepository(ref.read(carServiceProvider));
});