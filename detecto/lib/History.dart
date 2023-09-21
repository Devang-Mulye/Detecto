import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isImageSelected = false;
  bool isVideoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Screen"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isImageSelected = !isImageSelected;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: isImageSelected ? Colors.blue : Colors.grey, // Color for the image history section
              child: Center(
                child: Text(
                  "Image History",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isVideoSelected = !isVideoSelected;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: isVideoSelected ? Colors.green : Colors.grey, // Color for the video history section
              child: Center(
                child: Text(
                  "Video History",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (isImageSelected && isVideoSelected) {
                // Both options are selected, navigate to the page that displays history of both
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryOfBothPage(),
                  ),
                );
              } else if (isImageSelected) {
                // Only image history is selected, navigate to the image history page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageHistoryPage(),
                  ),
                );
              } else if (isVideoSelected) {
                // Only video history is selected, navigate to the video history page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoHistoryPage(),
                  ),
                );
              } else {
                // Show a message if no option is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please select either Image History or Video History."),
                  ),
                );
              }
            },
            child: const Text("Proceed"),
          ),
        ],
      ),
    );
  }
}

class ImageHistoryPage extends StatelessWidget {
  const ImageHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your content for image history
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image History"),
      ),
      body: const Center(
        child: Text("This is the Image History Page"),
      ),
    );
  }
}

class VideoHistoryPage extends StatelessWidget {
  const VideoHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your content for video history
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video History"),
      ),
      body: const Center(
        child: Text("This is the Video History Page"),
      ),
    );
  }
}

class HistoryOfBothPage extends StatelessWidget {
  const HistoryOfBothPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your content for history of both
    return Scaffold(
      appBar: AppBar(
        title: const Text("History of Both"),
      ),
      body: const Center(
        child: Text("This is the History of Both Page"),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: HistoryScreen(),
    ),
  );
}
