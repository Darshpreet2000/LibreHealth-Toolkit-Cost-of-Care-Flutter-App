import 'dart:async';

import 'package:cost_of_care/models/user_location_data.dart';
import 'package:cost_of_care/network/location_client.dart';
import 'package:cost_of_care/repository/abstract/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../main.dart';

class LocationRepoImpl implements LocationRepository {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData position;

  @override
  Future<String> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("Location not found");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.deniedForever) {
        throw Exception("Permission Denied, Enable from Settings");
      }
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("Location Permission Denied");
      }
    }

    LocationClient locationClient =
        new LocationClient(Geolocator(), Location());
    UserLocationData data = await locationClient.getCurrentLocation();
    saveData(data);
    return data.address;
  }

  void saveData(UserLocationData userLocationData) {
    box.put('latitude', userLocationData.latitude);
    box.put('longitude', userLocationData.longitude);
    box.put('address', userLocationData.address);
    box.put('state', userLocationData.state);
    return;
  }

  @override
  Future<bool> checkSaved() async {
    if (box != null &&
        box.containsKey('latitude') &&
        box.containsKey('longitude') &&
        box.containsKey('address')) {
      return true;
    }
//If data is not present then ask for location & then store it in shared preference
    return false;
  }

  @override
  Future<String> getSaved() async {
    String address = await box.get('address');
    return address;
  }
}
