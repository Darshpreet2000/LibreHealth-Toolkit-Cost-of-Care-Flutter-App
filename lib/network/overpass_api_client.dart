import 'dart:async';

import 'package:cost_of_care/models/hospitals.dart';
import 'package:cost_of_care/util/api_config.dart';
import 'package:dio/dio.dart';
import 'dart:math';
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
    List<Hospitals> hospitalList = [];
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
      distance = distanceInKM(double.parse(latitude), double.parse(longitude),
          double.parse(lat), double.parse(lon));
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

  double distanceInKM(double lat1, double lon1, double lat2, double lon2) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    return (dist);
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }
}
