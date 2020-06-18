import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationRepository {
  Future<String> getLocationPermission(); // To get Location Permission
  Future<String> getLocation(); //Get address & coordinates of user location
  Future<bool> checkSaved();
  Future<String> getSaved();
}

class Location_Repository implements LocationRepository {
  SharedPreferences prefs;
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
    prefs = await SharedPreferences.getInstance();
    try {
      position =
      await location.getLocation().timeout(const Duration(seconds: 10));

    }on TimeoutException catch (e) {
      return 'Network Problem';
    }
    //Save coordinate in shared preference
    //To use it in Overpass API
    await prefs.setString('latitude', position.latitude.toString());
    await prefs.setString('longitude', position.longitude.toString());
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
      await prefs.setString('address', address);
      return address;
    } on PlatformException {
      return 'Location Not Found';
    }
  }

  @override
  Future<bool> checkSaved() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('latitude') &&
        prefs.containsKey('longitude') &&
        prefs.containsKey('address')) {
      return true;
    }
//If data is not present then ask for location & then store it in shared preference
    return false;
  }

  @override
  Future<String> getSaved() async {
    prefs = await SharedPreferences.getInstance();
    String addr = await prefs.getString('address');
    return addr;
  }
}
