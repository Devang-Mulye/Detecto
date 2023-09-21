import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart'; // Import the video_player package

class WatermarkScreen extends StatefulWidget {
  const WatermarkScreen({Key? key}) : super(key: key);

  @override
  _WatermarkScreenState createState() => _WatermarkScreenState();
}

class _WatermarkScreenState extends State<WatermarkScreen> {
  File? _selectedFile;
  String? _errorMessage;
  final ImagePicker _imagePicker = ImagePicker();
  VideoPlayerController? _videoController; // Declare a VideoPlayerController

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(""); // Initialize with an empty asset
  }

  Future<void> _pickFile() async {
    final source = await showDialog<FileSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select File Type"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Image"),
              onTap: () {
                Navigator.of(context).pop(FileSource.image);
              },
            ),
            ListTile(
              title: const Text("Video"),
              onTap: () {
                Navigator.of(context).pop(FileSource.video);
              },
            ),
          ],
        ),
      ),
    );

    if (source == null) {
      // User canceled file selection
      return;
    }

    final pickedFile = source == FileSource.image
        ? await _imagePicker.pickImage(source: ImageSource.gallery)
        : await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _errorMessage = null; // Clear any previous error message
        if (_selectedFile!.path.endsWith('.mp4')) {
          _videoController!.dispose(); // Dispose of the previous controller
          _videoController = VideoPlayerController.file(_selectedFile!)
            ..initialize().then((_) {
              _videoController!.play();
            });
        }
      });
    } else {
      setState(() {
        _selectedFile = null;
        _errorMessage = "Please upload a file.";
      });
    }
  }

  void _proceed() {
    if (_selectedFile != null) {
      // File is uploaded, navigate to the next screen.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProceedScreen(
            selectedFile: _selectedFile!,
            videoController: _videoController, // Pass the video controller
          ),
        ),
      );
    } else {
      // Show an error message if no file is uploaded.
      setState(() {
        _errorMessage = "Please upload a file.";
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
        title: const Text("Watermark Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedFile != null)
              _selectedFile!.path.endsWith('.mp4')
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(_videoController!), // Use VideoPlayer widget
                    )
                  : Image.file(
                      _selectedFile!,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    )
            else
              const Icon(
                Icons.image,
                size: 100.0,
                color: Colors.grey,
              ),
            const SizedBox(height: 20.0),
            const Text(
              "This is the Watermark Screen",
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
              onPressed: _pickFile,
              child: const Text("Upload File"),
            ),
            ElevatedButton(
              onPressed: _proceed,
              child: const Text("Proceed"),
            ),
          ],
        ),
      ),
    );
  }
}

enum FileSource { image, video }

class ProceedScreen extends StatelessWidget {
  final File selectedFile;
  final VideoPlayerController? videoController; // Receive the video controller

  const ProceedScreen({
    Key? key,
    required this.selectedFile,
    this.videoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proceed Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedFile.path.endsWith('.mp4') && videoController != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(videoController!), // Use VideoPlayer widget with received controller
              )
            else
              Image.file(
                selectedFile,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20.0),
            const Text(
              "Proceed with the selected file",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: WatermarkScreen(),
    ),
  );
}
