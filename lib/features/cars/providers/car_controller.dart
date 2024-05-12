
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/data/repositories/car_repository.dart';
import 'package:parking_client/features/cars/providers/states/car_state.dart';

class CarController extends StateNotifier<CarState> {
  Ref ref;

  CarController(this.ref) : super(const CarInitial());


  Future<void> getCarDetail(List<String> carIds) async {
    state = const CarLoading();
    try {
      final cars = await ref.read(carRepositoryProvider).getCarDetail(carIds);
      state = CarSuccess(cars!);
    } catch (e) {
      state = CarFailure(e.toString());
    }
  }
  
}

final carControllerProvider = 
  StateNotifierProvider<CarController, CarState>((ref) => CarController(ref));