import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final bool isLoading;  // Determines whether to show the HUD
  final Widget child;    // The content over which the HUD is displayed

  const ProgressHUD({
    super.key,
    required this.isLoading,  // True if loading, false otherwise
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        children: [
          child,  // Main content
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,  // Semi-transparent overlay
              child: Container(
                color: Colors.black,  // Background color for the overlay
                child: const Center(
                  child: CircularProgressIndicator(),  // The loader
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return child;  // If not loading, just return the child
    }
  }
}
