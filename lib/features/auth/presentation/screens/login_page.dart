import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_client/features/auth/providers/login_controller_provider.dart';
import 'package:parking_client/features/auth/providers/states/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: const Offset(0, 10),
                        blurRadius: 20)
                  ]),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Text('Login',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (String? input) => validateEmail(input!),
                        decoration: InputDecoration(
                            hintText: 'Email address',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.2),
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).cardColor,
                            )),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).cardColor,
                            ))),
                    const SizedBox(height: 25),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) => validatePassword(value!),
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.2),
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).cardColor,
                            )),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).cardColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.4),
                                )))),
                    if (loginState is LoginFailure)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Login Failed: ${loginState.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ), // Display error message when login fails
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _handleLogin();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/register');
                        },
                        child: const Text(
                          "Don't have an account? Register",
                          style: TextStyle(
                            color: Colors.blue, // Hyperlink-like color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _handleLogin() {
    if (validateAndSave()) {
      ref
          .read(loginControllerProvider.notifier)
          .login(emailController.text, passwordController.text);
    }
  }

  //email validator
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    const String p = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final RegExp regExp = RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'Email is not valid';
    }
    return null;
  }

  //password validator
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
