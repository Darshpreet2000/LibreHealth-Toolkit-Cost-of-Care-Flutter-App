import 'dart:async';

import 'package:curativecare/repository/location_repository.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';

import '../main.dart';

class LocationServices implements LocationRepository {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData position;

  @override
  Future<String> getLocationPermission() async {
    //Ask for Location permissions & Location Services
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return 'Location Not Found';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return 'Location Not Found';
      }
    }
    return getLocation();
  }

  @override
  Future<String> getLocation() async {
    try {
      position =
          await location.getLocation().timeout(const Duration(seconds: 10));
    } on TimeoutException catch (e) {
      return 'Network Problem';
    }
    //Save coordinate in shared preference
    //To use it in Overpass API
    box.put('latitude', position.latitude.toString());
    box.put('longitude', position.longitude.toString());
    try {
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      String address = placemark[0].name +
          ", " +
          placemark[0].subLocality +
          ", " +
          placemark[0].locality +
          ", " +
          placemark[0].country;
      //Save address
      await box.put('address', address);
      return address;
    } on PlatformException {
      return 'Location Not Found';
    }
  }

  @override
  Future<bool> checkSaved() async {

    if (box.containsKey('latitude') &&
        box.containsKey('longitude') &&
        box.containsKey('address')) {
      return true;
    }
//If data is not present then ask for location & then store it in shared preference
    return false;
  }

  @override
  Future<String> getSaved() async {
    String addr = await box.get('address');
    return addr;
  }
}
