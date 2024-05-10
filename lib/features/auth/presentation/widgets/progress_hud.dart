import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {

  const ProgressHUD({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),  // Background color for the overlay
              child: const Center(
                child: CircularProgressIndicator(),  // The loader
              ),
            ),
          ),
        ],
      );
    } 

}
