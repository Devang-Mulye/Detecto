import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this with your image widget or logic
            Image.asset(
              'assets/your_image.png', // Replace with the path to your image asset
              width: 200.0, // Set the width of the image
              height: 200.0, // Set the height of the image
              fit: BoxFit.cover, // Adjust the BoxFit to your preference
            ),
            const SizedBox(height: 20.0), // Space between image and text
            const Text(
              "This is the Image Screen",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the floating action button here
        },
        child: const Icon(Icons.add), // You can change the icon as needed
      ),
    );
  }
}
