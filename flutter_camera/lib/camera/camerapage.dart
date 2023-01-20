import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  const CameraPage({super.key, required this.camera});

  @override
  State<CameraPage> createState() => _CameraPageState(camera: camera);
}

class _CameraPageState extends State<CameraPage> {
  final CameraDescription camera;
  _CameraPageState({required this.camera});
  late CameraController _controller;
  late Future<void> _initialControllerFuture;

  @override
  void initState() {
    _controller = CameraController(camera, ResolutionPreset.medium);
    _initialControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('take photo'),
      ),
      body: FutureBuilder<void>(
          future: _initialControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initialControllerFuture;
            final image = await _controller.takePicture();
            final im = File(image.path);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                          imagePath: image.path,
                        )));
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
