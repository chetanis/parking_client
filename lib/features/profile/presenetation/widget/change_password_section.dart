import 'package:flutter/material.dart';

class ChangePasswordSection extends StatelessWidget {
  const ChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.lock),
        const SizedBox(width: 15),
        const Text(
          "Change Password",
          style: TextStyle(fontSize: 17),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          iconSize: 18,
          onPressed: () {
            // reddirect to the change password
          },
        ),
      ],
    );
  }
}
