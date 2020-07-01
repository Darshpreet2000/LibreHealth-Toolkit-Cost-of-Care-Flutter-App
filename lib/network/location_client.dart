import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../main.dart';

class LocationClient {
  Location location = new Location();
  LocationData position;

  Future<String> getCurrentLocation() async {
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
          placemark[0].administrativeArea +
          ", " +
          placemark[0].country;
      //Save address
      //HardCoding for now State
      //box.put('state',placemark[0].administrativeArea);
      box.put('state', placemark[0].administrativeArea);
      await box.put('address', address);
      return address;
    } on PlatformException {
      return 'Location Not Found';
    }
  }
}
