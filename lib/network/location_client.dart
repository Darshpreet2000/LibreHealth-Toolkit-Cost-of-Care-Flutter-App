import 'dart:async';
import 'package:cost_of_care/models/user_location_data.dart';
import 'package:cost_of_care/util/states_abbreviation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gps/gps.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationClient {
  GpsLatlng position;
  String state;
  String address;
  LocationClient();
  Future<void> execute() async {
    if (await Permission.location.isPermanentlyDenied) {
      throw Exception("Permission Denied, Enable from Settings");
    }
    PermissionStatus permissionStatus =
        await Permission.locationWhenInUse.request();
    if (permissionStatus.isGranted) {
      //check service status
      bool serviceStatus =
          await Permission.locationWhenInUse.serviceStatus.isEnabled;
      if (serviceStatus == false) {
        throw Exception("You need to Enable GPS/Location Service");
      }
    } else {
      throw Exception("Permission Denied, Enable from Settings");
    }
  }

  Future<UserLocationData> getCurrentLocation() async {
    await execute();
    bool serviceStatus =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (serviceStatus == false) {
      throw Exception("You need to Enable GPS/Location Service");
    }
    try {
      position = await Gps.currentGps();

      if (position == null) throw Exception("Location Not Found");
    } catch (e) {
      throw Exception("Location Not Found");
    }
    try {
      List<Placemark> placeMark = await placemarkFromCoordinates(
          double.parse(position.lat), double.parse(position.lng),
          localeIdentifier: "en");
      address = placeMark[0].name +
          ", " +
          placeMark[0].locality +
          ", " +
          placeMark[0].administrativeArea +
          ", " +
          placeMark[0].country;
      //Save address
      StatesAbbreviation statesAbbreviation = new StatesAbbreviation();
      if (placeMark[0].administrativeArea.length == 2 &&
          statesAbbreviation.containsState(placeMark[0].administrativeArea)) {
        state =
            statesAbbreviation.getStateName(placeMark[0].administrativeArea);
      } else {
        state = placeMark[0].administrativeArea;
      }
      return UserLocationData(state, double.parse(position.lat),
          double.parse(position.lng), address);
    } catch (e) {
      throw Exception("Location Not Found");
    }
  }
}
