import 'package:flutter/material.dart';

import 'History.dart';
import 'ImageScreen.dart';
import 'VideoScreen.dart';
import 'Watermark.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Functionality for Button 1
    void handleButton1() {
      // Navigate to a new Dart file/screen for Image with a Hero transition
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageScreen(),
        ),
      );
    }

    // Functionality for Button 2
    void handleButton2() {
      // Navigate to a new Dart file/screen for Video with a Hero transition
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VideoScreen(),
        ),
      );
    }

    // Functionality for Button 3
    void handleButton3() {
      // Navigate to a new Dart file/screen for Watermark with a Hero transition
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WatermarkScreen(),
        ),
      );
    }

    // Functionality for Button 4
    void handleButton4() {
      // Navigate to a new Dart file/screen for History with a Hero transition
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryScreen(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 87, 93, 99), // Background color for both parts
        child: Column(
          children: [
            // 75% part with a local GIF
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.67, // 75% of available height
              child: FractionallySizedBox(
                widthFactor: 1.0, // 100% of available width
                heightFactor: 1.0, // 100% of available height
                child: Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'gif', // Unique tag for the Hero animation
                    child: Image.asset(
                      'assets/cat-vibrate.gif', // Replace with the path to your local GIF asset
                      // Make sure the GIF file is placed in the "assets" folder of your project
                      fit: BoxFit.cover, // You can adjust the BoxFit to your preference
                    ),
                  ),
                ),
              ),
            ),

            // 25% part with four buttons in a grid
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.33, // 25% of available height
              child: FractionallySizedBox(
                widthFactor: 1.0, // 100% of available width
                heightFactor: 1.0, // 100% of available height
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: const Color.fromARGB(255, 205, 223, 238), // Adjust the color as needed
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2.0,
                    children: [
                      ElevatedButton(
                        onPressed: handleButton1,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0), // Adjust button padding for smaller size
                        ),
                        child: const Text(
                          "Image",
                          style: TextStyle(fontSize: 35.0), // Adjust text size for smaller buttons
                        ),
                      ),
                      ElevatedButton(
                        onPressed: handleButton2,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0), // Adjust button padding for smaller size
                        ),
                        child: const Text(
                          "Video",
                          style: TextStyle(fontSize: 35.0), // Adjust text size for smaller buttons
                        ),
                      ),
                      ElevatedButton(
                        onPressed: handleButton3,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0), // Adjust button padding for smaller size
                        ),
                        child: const Text(
                          "Watermark",
                          style: TextStyle(fontSize: 35.0), // Adjust text size for smaller buttons
                        ),
                      ),
                      ElevatedButton(
                        onPressed: handleButton4,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0), // Adjust button padding for smaller size
                        ),
                        child: const Text(
                          "History",
                          style: TextStyle(fontSize: 35.0), // Adjust text size for smaller buttons
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
