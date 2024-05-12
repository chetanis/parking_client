import 'package:equatable/equatable.dart';
import 'package:parking_client/features/cars/data/models/car.dart';

class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
  
}

class CarInitial extends CarState {
  const CarInitial();

  @override
  List<Object> get props => [];
}

class CarLoading extends CarState {
  const CarLoading();

  @override
  List<Object> get props => [];
}

class CarSuccess extends CarState {
  final List<Car> cars;
  const CarSuccess(this.cars);

  @override
  List<Object> get props => [cars];
}

class CarFailure extends CarState {
  final String error;

  const CarFailure(this.error);

  @override
  List<Object> get props => [error];
}