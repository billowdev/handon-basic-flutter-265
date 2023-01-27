import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(17.188360, 104.088865), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(17.188360, 104.088865),
            infoWindow: InfoWindow(title: "SNRU", snippet: "UNIVERSITY"),
          ),
          Marker(
              markerId: MarkerId("2"), position: LatLng(17.146101, 104.117117))
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCurrentPosition,
        label: Text('My location'),
        icon: Icon(Icons.my_location),
      ),
    );
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    try {
      return await location.getLocation();
    } catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
// // Permission denied

//       }

      return null;
    }
  }

  Future _goToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;

    currentLocation = (await getCurrentLocation())!;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 16,
    )));
  }
}
