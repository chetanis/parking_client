import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.freezed.dart';
part 'car.g.dart';


@freezed
class Car with _$Car {
  const factory Car({
    required String id,
    required String model,
    required String licenseNumber,
    required String serialNumber,
  }) = _Car;

  factory Car.fromJson(Map<String, Object?> json)
      => _$CarFromJson(json);
}