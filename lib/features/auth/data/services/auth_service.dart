import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  String loginBaseUrl = 'https://reqres.in/api/login';
  String registerBaseUrl = 'https://reqres.in/api/login';

  Future<void> login(String email, String password) async {

    final reponse = await http.post(Uri.parse(loginBaseUrl), body: {
      'email': email,
      'password': password 
    });
    
    if(reponse.statusCode == 200) {
      await storeToken(reponse.body);
    } else {
      throw Exception('Failed to login');
    }

  }

  Future<void> register(String email,String password, String lastName, String name, String phone, String carModel, String mat,String vf) async {
    try {
      final response = await http.post(Uri.parse(registerBaseUrl), body: {
        'email': email,
        'password': password,
        'lastName': lastName,
        'name': name,
        'phone': phone,
        'carModel': carModel,
        'mat': mat,
        'vf': vf
      });

      if(response.statusCode == 200) {
        await storeToken(response.body);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register');
    }
  }

  Future<void> signOut() async {
    // Implementation
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}

final authServiceReProvider = Provider<AuthService>((ref) => AuthService());