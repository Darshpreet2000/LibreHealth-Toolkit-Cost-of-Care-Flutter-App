import 'dart:async';
import 'package:curativecare/models/user_location_data.dart';
import 'package:curativecare/util/states_abbreviation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationClient {
  LocationData position;
  String state;
  String address;
  Geolocator geoLocator;
  Location location;

  LocationClient(this.geoLocator, this.location);

  Future<UserLocationData> getCurrentLocation() async {
    try {
      position = await location.getLocation();
    } catch (e) {
      throw Exception("Network Problem");
    }
    try {
      List<Placemark> placeMark = await geoLocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
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

      return UserLocationData(
          state, position.latitude, position.longitude, address);
    } catch (e) {
      throw Exception("Location Not Found");
    }
  }
}
