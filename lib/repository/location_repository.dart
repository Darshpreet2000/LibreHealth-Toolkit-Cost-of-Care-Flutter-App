import 'dart:html';
import 'package:curativecare/models/location.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationRepository {
  Future<Location> getLocationPermission();// To get Location Permission
  Future<Location> getLocation(); //Get address & coordinates of user location
}

class Location_Repository implements LocationRepository {
  SharedPreferences prefs;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData position;

  @override
  Future<Location> getLocationPermission() async {
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
  Future<Location> getLocation() async {
    prefs = await SharedPreferences.getInstance();
    position = await location.getLocation();
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
      prefs.setString('address', address);
      return Location(position.latitude.toString(),position.longitude,address);
    } on PlatformException catch (e) {
      return 'Location Not Found';
    }
  }
}
