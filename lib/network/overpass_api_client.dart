import 'dart:async';

import 'package:cost_of_care/models/hospitals.dart';
import 'package:cost_of_care/util/api_config.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../main.dart';

class OverpassAPIClient {
  String latitude;
  String radius = '15000';
  String longitude;
  Dio dio = new Dio();
  var openBox = box;

  Future fetchNearbyHospitals() async {
    String nearbyHospitalApi = ApiConfig().nearbyHospitalApi;
    latitude = openBox.get('latitude').toString();
    longitude = openBox.get('longitude').toString();
    if (openBox.containsKey('radius')) {
      radius = openBox.get('radius');
      int radiusInt = int.parse(radius) * 1000;
      radius = radiusInt.toString(); //converting to metres
    }
    String nearbyHospital =
        """[out:json];(node["amenity"="hospital"](around:$radius,$latitude,$longitude);way["amenity"="hospital"](around:$radius,$latitude,$longitude);relation["amenity"="hospital"](around:$radius,$latitude,$longitude););out center;""";
    print(nearbyHospitalApi + nearbyHospital);
    try {
      final response = await dio.get(nearbyHospitalApi + nearbyHospital);
      if (response.statusCode == 200)
        return response;
      else
        throw Exception('Failed to load nearby hospitals');
    } catch (e) {
      if (e is DioError) {
        if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
            DioErrorType.CONNECT_TIMEOUT == e.type) {
          throw Exception(
              "Please check your internet connection and try again");
        } else if (DioErrorType.DEFAULT == e.type) {
          if (e.message.contains('SocketException')) {
            throw Exception('No Internet Connection');
          }
        }
        throw Exception("Problem connecting to the server. Please try again.");
      }
      throw Exception("Problem connecting to the server. Please try again.");
    }
  }

  Future<List<Hospitals>> parseHospitalJsonData(
      Map<String, dynamic> responseBody) async {
    List<Hospitals> hospitalList = new List();
    latitude = box.get('latitude').toString();
    longitude = box.get('longitude').toString();
    Map<String, dynamic> parsedJson = (responseBody);
    var elements = parsedJson['elements'] as List;
    for (int i = 0; i < elements.length; i++) {
      String name, operator, beds, lat, lon;
      Future<String> path;
      double distance;
      Map<String, dynamic> currentHospital = elements[i];
      if (currentHospital.containsKey('center')) {
        Map<String, dynamic> center = currentHospital['center'];
        lat = center['lat'].toString();
        lon = center['lon'].toString();
      } else {
        lat = currentHospital['lat'].toString();
        lon = currentHospital['lon'].toString();
      }
      distance = await Geolocator().distanceBetween(double.parse(latitude),
              double.parse(longitude), double.parse(lat), double.parse(lon)) /
          1000;
      distance = num.parse(distance.toStringAsFixed(2));
      Map<String, dynamic> tags = currentHospital['tags'];
      name = tags['name'];
      if (name == null) name = 'N/A';
      operator = tags['operator'];
      if (operator == null) {
        operator = 'N/A';
      }
      beds = tags['beds'];
      if (beds == null) {
        beds = 'N/A';
      }

      Hospitals nearbyHospital =
          new Hospitals(name, path, distance.toString(), beds);
      hospitalList.add(nearbyHospital);
    }
    return hospitalList;
  }
}
