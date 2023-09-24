import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'ResultScreen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? _videoFile;
  String? _errorMessage;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(""); // Initialize with an empty asset, will be updated when a video is picked
  }
Future<void> _pickVideo() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _videoFile = File(pickedFile.path);
      _errorMessage = null; // Clear any previous error message
      _videoController = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          // Ensure the first frame is shown
          setState(() {
            _videoController!.play(); // Start playing the video
          });
        });
    });
  } else {
    setState(() {
      _videoFile = null;
      _videoController = null;
      _errorMessage = "Please upload a video first.";
    });
  }
}


  // Function to navigate to the ResultScreen
  void _navigateToResultScreen() {
    if (_videoFile != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(),
        ),
      );
    } else {
      // Show an error message if no video is uploaded
      setState(() {
        _errorMessage = "Please upload a video first.";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null)
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              )
            else
              const Icon(
                Icons.video_collection,
                size: 100.0,
                color: Colors.grey,
              ),
            const SizedBox(height: 20.0),
            const Text(
              "This is the Video Screen",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _navigateToResultScreen, // Navigate to the ResultScreen
              child: const Text("Next"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
