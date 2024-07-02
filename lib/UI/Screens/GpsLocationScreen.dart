import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Gps extends StatefulWidget {
  const Gps({super.key});

  @override
  State<Gps> createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LocationDisplay(),
      ),
    );
  }
}

class LocationDisplay extends StatefulWidget {
  @override
  _LocationDisplayState createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {
  String _latitude = 'Latitude: Loading...';
  String _longitude = 'Longitude: Loading...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        _latitude = 'Latitude: ${position.latitude}';
        _longitude = 'Longitude: ${position.longitude}';
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _latitude,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        SizedBox(height: 16),
        Text(
          _longitude,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
