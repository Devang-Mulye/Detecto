import 'package:flutter/material.dart';


class WatermarkScreen extends StatelessWidget {
  const WatermarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watermark Screen"),
      ),
      body: const Center(
        child: Text("This is the Watermark Screen"),
      ),
    );
  }
}