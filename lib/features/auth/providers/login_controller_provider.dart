import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/auth/data/repositories/auth_repository.dart';
import 'package:parking_client/features/auth/providers/states/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends StateNotifier<LoginState>{
  LoginController(this.ref) : super(const LoginInitial()){
    _checkToken();
  }
  final Ref ref;

  void login(String email,String password) async {
    state = const LoginLoading();
    try {
      await ref.read(authRepositoryProvider).login(email, password);
      state = const LoginSuccess();
    } catch (e) {
      state = LoginFailure(e.toString(), 'login');
    }
  }

  void register(String email, String password, String lastName, String name, String phone, String carModel, String mat, String vf) async {
    state = const LoginLoading();
    try {
      await ref.read(authRepositoryProvider).register(email, password, lastName, name, phone, carModel, mat, vf);
      state = const LoginSuccess();
    } catch (e) {
      state = LoginFailure(e.toString(), 'register');
    }
  }
  
  Future<void> _checkToken() async{
    final sherd = await SharedPreferences.getInstance();
    final token = sherd.getString('token');
    if(token != null){
      state = const LoginSuccess();
    }
  }
}



final loginControllerProvider = 
  StateNotifierProvider<LoginController, LoginState>((ref) => LoginController(ref));