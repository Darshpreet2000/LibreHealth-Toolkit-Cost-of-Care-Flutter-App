import 'dart:async';

import 'package:cost_of_care/models/user_location_data.dart';
import 'package:cost_of_care/network/location_client.dart';
import 'package:cost_of_care/repository/abstract/location_repository.dart';

import '../main.dart';

class LocationRepoImpl implements LocationRepository {
  @override
  Future<String> getLocation() async {
    LocationClient locationClient = new LocationClient();
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
