import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String lastName,
    required String email,
    required String password,
    required List<String> carIds,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}