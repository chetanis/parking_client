import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_client/features/auth/presentation/screens/login_page.dart';
import 'package:parking_client/features/auth/presentation/screens/register_page.dart';
import 'package:parking_client/features/auth/providers/login_controller_provider.dart';
import 'package:parking_client/features/auth/providers/states/login_state.dart';
import 'package:parking_client/features/profile/presenetation/screens/profile_page.dart';
import 'package:parking_client/features/scanner/presentaion/screens/home_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: (context, state) => router._redirectLogic(state),
    routes: router.routes, // Public getter
    initialLocation: '/', // Ensure initial location is valid
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref ref;

  RouterNotifier(this.ref) {
    ref.listen<LoginState>(
      loginControllerProvider,
      (previous, next) {
          notifyListeners(); // Notify if the state changes
      },
    );
  }

  List<GoRoute> get routes => [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => const UserProfilePage(),
    ),
  ];

  String? _redirectLogic(GoRouterState state) {
    final loginState = ref.read(loginControllerProvider);
    final isLoginPage = state.uri.path == '/login';
    final isRegisterPage = state.uri.path == '/register';



    if (loginState is LoginInitial) {
      return isLoginPage||isRegisterPage ? null : '/login'; // Redirect to login if not on the login page
    } 
    
    if (loginState is LoginLoading) {
      return null; // Redirect to loading page if login is loading
    }

    if (loginState is LoginFailure) {
      return null; // Default: no redirection
    }

    if (isLoginPage || isRegisterPage) return '/';



    return null; // Default: no redirection
  }
}
