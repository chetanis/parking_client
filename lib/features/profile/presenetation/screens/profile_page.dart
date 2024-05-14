import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/providers/car_controller.dart';
import 'package:parking_client/features/cars/providers/states/car_state.dart';
import 'package:parking_client/features/profile/presenetation/widget/change_password_section.dart';
import 'package:parking_client/features/profile/presenetation/widget/my_cars_sections.dart';
import 'package:parking_client/features/profile/presenetation/widget/user_info_section.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    var carState = ref.read(carControllerProvider);
    if (carState is CarSuccess) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    offset: const Offset(0, 10),
                    blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const UserInfoSection(),
                const SizedBox(
                  height: 10,
                ),
                const ChangePasswordSection(),
                const SizedBox(height: 15),
                SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                        child: MyCarsSection(cars: carState.cars))),
                const Spacer(),
                _buildSignOut()
              ],
            ),
          ),
        ),
      );
    }

    // Show loading if no cars or no user yet

    return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: const Center(
            child:
                CircularProgressIndicator())); 
  }

  Widget _buildSignOut() {
    return Consumer(
      builder: (context, ref, child) {
        return Row(
          children: [
            const Icon(
              Icons.logout,
            ), // Icon indicating logout
            const SizedBox(width: 15), // Spacing between icon and text
            const Text("Logout",
                style: TextStyle(
                  fontSize: 17,
                )), // Text for logout
            const Spacer(), // Pushes the arrow to the right
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
              ), // Arrow pointing right
              iconSize: 18,
              onPressed: () {
                // ref.read(loginControllerProvider.notifier).signOut(); //signout
              },
            ),
          ],
        );
      },
    );
  }
}
