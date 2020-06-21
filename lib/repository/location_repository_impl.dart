import 'dart:async';

import 'package:curativecare/network/location_client.dart';
import 'package:curativecare/repository/abstract/location_repository.dart';
import 'package:location/location.dart';

import '../main.dart';

class LocationRepoImpl implements LocationRepository {
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
    LocationClient locationClient = new LocationClient();
    Future<String> address = locationClient.getCurrentLocation();
    return address;
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
