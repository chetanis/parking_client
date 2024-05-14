import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("John Doe"),
            Text("john.doe@example.com"),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.edit),
          iconSize: 18,
          onPressed: () {
            // Handle user information editing
          },
        ),
      ],
    );
  }
}