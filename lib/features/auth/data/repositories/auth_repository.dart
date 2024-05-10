import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/auth/data/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> login(String email, String password) async {
    return _authService.login(email, password);
  }

  Future<void> register(String email,String password, String lastName, String name, String phone, String carModel, String mat,String vf) async {
    return _authService.register(email, password, lastName, name, phone, carModel, mat, vf);
  }

}
final authRepositoryProvider = Provider<AuthRepository>((ref) { 
  return AuthRepository(ref.read(authServiceReProvider));
  });