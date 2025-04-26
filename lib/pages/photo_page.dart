import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/services/api_service.dart';
import 'package:provider/provider.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E6E6), // Light pink
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: const Color(0xFF482B0C), // Dark brown
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 0), // Empty space to center button
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE58A1F), // Orange button
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), 
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _takePicture() async {
    var setter = context.read<AppModel>();
    var msgr = ScaffoldMessenger.of(context);

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;

      File file = File(image.path);
      String body = await ApiService.uploadImage(setter.token, file);

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      msgr.showSnackBar(SnackBar(content: Text('Error: $e')));
      debugPrint(e.toString());
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
        backgroundColor: const Color(0xFF482B0C),
      ),
      backgroundColor: const Color(0xFFF4E6E6),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
