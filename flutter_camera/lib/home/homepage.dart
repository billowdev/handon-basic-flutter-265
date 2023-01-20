import 'package:camera/camera.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/camera/camerapage.dart';

class MyHomePage extends StatefulWidget {
  final String pageTitle;
  final CameraDescription camera;
  const MyHomePage({super.key, required this.pageTitle, required this.camera});

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(pageTitle: pageTitle, camera: camera);
}

class _MyHomePageState extends State<MyHomePage> {
  final String pageTitle;
  final CameraDescription camera;
  _MyHomePageState({required this.pageTitle, required this.camera});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
              bottom: TabBar(onTap: (index) {}, tabs: const <Tab>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.camera)),
                Tab(icon: Icon(Icons.camera_alt)),
              ]),
            ),
            body: TabBarView(children: <Widget>[
              Center(
                child: Text('Home Tab'),
              ),
              // Center(
              //   child: Text('Camera 1'),
              // ),
              CameraPage(camera: camera),
              Center(
                child: Text('Camera 2'),
              ),
            ]),
          ),
        ));
  }
}
