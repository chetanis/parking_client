import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_client/features/auth/providers/login_controller_provider.dart';
import 'package:parking_client/features/auth/providers/states/login_state.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController matController = TextEditingController();
  TextEditingController vfController = TextEditingController();

  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text('Creé un compte',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  const SizedBox(height: 40),
                  Text('Information personnel :',
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: lastNameController,
                      validator: lastNameValidator,
                      decoration: InputDecoration(
                        hintText: 'Nom',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: nameValidator,
                      decoration: InputDecoration(
                        hintText: 'Prénom',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: emailValidator,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 25),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: phoneValidator,
                      decoration: InputDecoration(
                        hintText: 'Numéro de téléphone',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 25),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      validator: passwordValidator,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 13, bottom: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).cardColor,
                          )),
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
                  const SizedBox(height: 25),
                  Text('Information voiture :',
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: carModelController,
                      validator: modelValidator,
                      decoration: InputDecoration(
                        hintText: 'Modele',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: matController,
                      validator: imatriculationValidator,
                      decoration: InputDecoration(
                        hintText: 'Imatriculation: 123456.123.12',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      maxLength: 50, // Maximum length of 50 characters
                      keyboardType: TextInputType.text,
                      controller: vfController,
                      validator: alphanumericValidator,
                      decoration: InputDecoration(
                        hintText: 'N° dans la serie du type',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 13, bottom: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        )),
                      )),
                  if (loginState is LoginFailure)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Register Failed: ${loginState.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ), // Display error message when login fails
                  const SizedBox(height: 25),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _handleRegister();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).cardColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text('Register',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).go('/login'); // Navigate to the login screen
                      },
                      child: const Text(
                        "Already have an account? Log in",
                        style: TextStyle(
                          color: Colors.blue, // Hyperlink-like color
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String? emailValidator(String? input) {
    final regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'); // Email pattern
    if (input == null || input.isEmpty) {
      return "L'email ne peut pas être vide"; // Check for empty input
    }
    if (!regex.hasMatch(input)) {
      return "Le format de l'email est invalide."; // Error message for invalid email
    }
    return null; // Valid email
  }

  String? passwordValidator(String? input) {
    final regex = RegExp(r'^.{8,}$'); // Password pattern
    if (input == null || input.isEmpty) {
      return 'Le mot de passe ne peut pas être vide';
    }
    if (!regex.hasMatch(input)) {
      return 'Le mot de passe doit contenir au moins 8 caractères.'; // Return specific error message
    }
    return null; // Valid password
  }

  String? lastNameValidator(String? input) {
    final regex = RegExp(r'^[a-zA-Z]+$'); // Pattern to allow only letters
    if (input == null || input.isEmpty) {
      return 'Le nom ne peut pas être vide'; // Check for empty input
    }
    if (!regex.hasMatch(input)) {
      return 'Le nom doit contenir uniquement des lettres.'; // Error message for invalid input
    }
    return null; // Valid input
  }

  String? nameValidator(String? input) {
    final regex =
        RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$'); // Allows letters and spaces
    if (input == null || input.isEmpty) {
      return 'Le prénom ne peut pas être vide'; // Check for empty input
    }
    if (!regex.hasMatch(input)) {
      return 'Le prénom doit contenir uniquement des lettres.'; // Check for invalid characters
    }
    return null; // Valid input
  }

  String? alphanumericValidator(String? input) {
    final regex = RegExp(r'^[a-zA-Z0-9]+$'); // Alphanumeric pattern
    if (input == null || input.isEmpty) {
      return 'Le "N° dans la série du type" ne peut pas être vide'; // Check for empty input
    }
    if (!regex.hasMatch(input)) {
      return 'caractères invalides dans le "N° dans la série du type".';
    }
    return null; // Valid input
  }

  String? imatriculationValidator(String? input) {
    final regex =
        RegExp(r'^\d{6}\.\d{3}\.\d{2}$'); // This pattern matches 123456.123.12
    if (input == null || input.isEmpty) {
      return "L'immatriculation ne peut pas être vide."; // Check for empty input
    }
    if (!regex.hasMatch(input)) {
      return "Format d'immatriculation invalide.";
    }
    return null; // Valid input
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un numéro de téléphone';
    }

    RegExp regex = RegExp(
        r'^(05|06|07)\d{8}$'); // This pattern matches 05xxxxxxxx or 06xxxxxxxx or 07xxxxxxxx

    if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un numéro de téléphone valide';
    }

    return null;
  }

  String? modelValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un modèle de voiture';
    }

    RegExp regex = RegExp(
        r'^[a-zA-Z0-9\- ]+$'); // Allows letters, numbers, hyphens, and spaces

    if (!regex.hasMatch(value)) {
      return 'Modèle de voiture invalide';
    }

    return null; // No error if the car model name is valid
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _handleRegister() {
    if (validateAndSave()) {
      ref.read(loginControllerProvider.notifier).register(
          emailController.text,
          passwordController.text,
          lastNameController.text,
          nameController.text,
          phoneController.text,
          carModelController.text,
          matController.text,
          vfController.text);
      
    }
  }
}
